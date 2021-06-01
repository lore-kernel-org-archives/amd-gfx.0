Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E3AC4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 14:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81037610CB
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 14:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81037610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E5E36EA81;
	Tue,  1 Jun 2021 14:45:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B9C6EA81
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 14:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCa1XxNR0pX/U0+FbTLuuWyy/SLVKCuMjviqg/WDFlg9Nn6+zNxGEQG6LiHlx1IB+xXfhGAoz5M3WiAel9xZJ7RrzcrDIzEouDLAM22wiewi+K8uZMNqICEGfWt2GhWd2Bx24vPGug2e24NQroco9z1c5oXNx63NiE3b9MfJhCG7kTCyqoO9PWOe2/O2lXR38xNNFHWysxl/IjQOkgvfKBXu/LZ9R7zWW9G6HdR98voRotfFQI+Wh6oucw1V9ZEn4z7r2zTj9FMZgECGAIl6Ht9ZFRUtG4sT+7mwe/e3SlEn2J+/QskVx2bF15ZMHep/oBHSuCrlSOsj8tMNHaOtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXv6T0c4MI5+qlsjDQWb7SubvjUKkscRjklJuQpyaLw=;
 b=d16gMUReH34/UmeTeomopv2dnG4yWqsZTbds7RIl9zCxSAiAzsLYpBM0ywt0hE2/UfAeGO6fVCBs+2XaRIinR6r9hZ1ONANFNCMLFOmLMWOoXDaCizJnk2CXR8O1mGhUqTrAuBDPoX4DEsuS9tuDJwnOutd7DXZH6tzuTWVkYnEPNW5BQf+dd9aPK328lsI999rSNgy2PGoTVa40zJrcFbKmKuSHK7DUXN2a7jPS6gBcY3P9cQNKIT3RzXD3jnQuZIZt6cylKTrPK4lvEvYNCD8sTgllSUV7Yz9xtKss6tMBMkbiR3rn5DU2Tw4BCLBZxIc0aPrKIg126RNVnka/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXv6T0c4MI5+qlsjDQWb7SubvjUKkscRjklJuQpyaLw=;
 b=oYvwA8+PlDUOvjzCLHUqmBtjb5UTel0xAkQeMoY7Wdhw+vjq7qIjuKxmwZKXesBgGtifKCZVCvxtIZPctcdHAQ3lOIbgnymHjbp55Pnb7+LtxnvyDvn2kB6yQjIO03f0qSiSq2MI+OtvL2sCVJJ6otcVKcMNoSxNrsm6dnr2Zvc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB4562.namprd12.prod.outlook.com (2603:10b6:5:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 14:45:36 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 14:45:36 +0000
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Don't flush HDP on A+A
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210601000625.551445-1-jinhuieric.huang@amd.com>
 <20210601000625.551445-2-jinhuieric.huang@amd.com>
 <21f80a3a-b48d-3ee3-fabb-d1b377a51600@gmail.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <0da1d86e-b966-4103-119e-ed8ae6f53842@amd.com>
Date: Tue, 1 Jun 2021 10:45:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <21f80a3a-b48d-3ee3-fabb-d1b377a51600@gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2048:122:889c:5e2:3561:6b91]
X-ClientProxiedBy: YT2PR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::9) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:889c:5e2:3561:6b91]
 (2607:9880:2048:122:889c:5e2:3561:6b91) by
 YT2PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.28 via Frontend Transport; Tue, 1 Jun 2021 14:45:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9221b2f4-f0a5-4c8c-0352-08d9250beab7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4562:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4562FB5464FA713CCA6E2031823E9@DM6PR12MB4562.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sehC+MrklO+K9S9NrRj49xAekQkGoaZHMkHZ9AdfR9vSrZCiBWyd+rYGY9qjgsQmXIvtF/vXvTYpamLUfXPlO9hcJHJ8fihMGE/U3W1pPFljR4BrBL/UOG1RR0/lQxVOxOzX+kf+ltixyi0UUs+rfJtuZSE791BKaCbocaRuJPaIucpWw7wnRpSWhXjpDAqWYyDk+HmzCMWuUqRAjPb/5B0dozFWgcLLrSqBLs0lfWj32NxzA1pv8AINNNpksCKR6f5wQL1sbXqZF3wiquQr/4MLBk2lYWBiaBSOW3DQHoOMZ5zvqS2/vGlNFdVUTTnILOAaun+Vm/UuJu9Jvz33OCrWbx548I/MGJMsFSzNSgqrHzMbmycSk0QYgR+MYG9Q+bMGEYKlAYrBJBWHJA3W1dqCqvhRpQUsK5fbsCglstkz6eyWtFyaFTlt+rzMZsK/FXPnwrAhxJGXlMxtFRCB1ilhlnvKf49hlchtuHUG/t0CaEEa5QBsKGrftVoYgrjnMjwfh4KSXYx+7JJqXxKFDW8F6InRY9BdJDyk/s8e1k+WDIYDO2gvSsIx90GFZabbgjX+c8dWrIWZ+kb9lmkVx6Q+GQ+WpzfHzO40Tr1J6CyswRrjySzAQ4E6Rim0xftsvwKXDKOWUBK9AQMlxNZ/FjQY2yZzMYFOfXnDD8pbZQerisMtETIVBIIGPdEELtX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(83380400001)(6666004)(31696002)(8676002)(16526019)(66574015)(31686004)(86362001)(186003)(66946007)(66476007)(36756003)(53546011)(66556008)(8936002)(5660300002)(2906002)(316002)(38100700002)(2616005)(478600001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a0J0QzRUS201Qytzc0pYYnhaTDloL1ZlOHFzekRmNFZvWGNwNFh1WmpzUnM5?=
 =?utf-8?B?RVpHc3JJazl2V3VxUkZrTGVSYzhDR0lUcVBJVmZyQUhuVmZuQlBOWldTaFpR?=
 =?utf-8?B?OW1sVE1HMUJZdk95VFE5UnBrTTdKczNJbStXeTdzL0QzNkdLRWh6ejg0M1Ux?=
 =?utf-8?B?UDQrQ1NNZmh4d1pCbGI5QjBOUkppQktGVWg4V1NUQkdrOVdQZzdPRk1yc2F3?=
 =?utf-8?B?ZDI1dVM5VzBkRVd4cWxySHdxNXpPVHUzMTVEdE1lREw5ditteU0zSW9KdjN4?=
 =?utf-8?B?b3p0cVVPR0tUTGJGbi8wWlZYclU3ZklVT2ZESXFsL3pDWHlpWS9kYnk0Q2Nz?=
 =?utf-8?B?MElENkw2SmFjWmc4dHVQOTZXYkJuK0kveXFqdnd3MHZUK2cvWmRRTXNQSDlo?=
 =?utf-8?B?QTlPTkxvRE5BODJrSFFLRnNLS1hWdmtUS3pZdFJCMHNndVhPR3VocVdIRTA2?=
 =?utf-8?B?VlZlS1gyb0owSjVXUG5uajF6amRyNHV2eGRMV1AxaVBPWnFZYkJ1T044d1Zs?=
 =?utf-8?B?TGdiUlR0S1p6eEhWK2dIZi9pYXZlVzBwV2lxdGQyeng0SHNhNXRiZVJKaXRw?=
 =?utf-8?B?eVBzbDBKOHZzaXQwMU56MTJ4ay9pTUlsZGQyZFlYT3hpVTJ2TW56WlBhczZD?=
 =?utf-8?B?elhDU1NwY0Z2VUROa0I0RjhuOXk0cFhhLzVTWS9XZUNxa3lZOVB1SUREMjh5?=
 =?utf-8?B?YS9KaDJ4QnU2Yy9RdE11ZFkwTnN1UEZ6Y3VVd0hiMnlSZzJCYkFoUVZIWnQz?=
 =?utf-8?B?Ylp6NUtwdDZRUERYQ2xHY05UUGQvNitEWERBL3JNa0lKLy8wdjArSG84NEFa?=
 =?utf-8?B?bmw1MWhxc29LY3VQUENxT1dlZHYxS2Z2R1R5YkF3RkxoK3BCRlRLOCtIcWYr?=
 =?utf-8?B?SDhqLzl5czZWaEQvYTNBeVhuYlo5NHZGWnB2V3MwNGRIcFBwanZnKzdIRzZQ?=
 =?utf-8?B?ZkxBNyt6UHJGTDQ4RFBvWUtBS29LVUI3Q2J4TjlWZHdqUlAvOHQxV0JOUUJM?=
 =?utf-8?B?MHhDMDJCdW0rSVR4RUI2U0ZFQ016b3V1YWdKRlVUTUxCSDhVYW5KczdUSEw1?=
 =?utf-8?B?eWtsOWZMaG1lcWtkUFFWVTVmL05sMjIzenZLaCtybG9SUG5LUENTVHdINEJ6?=
 =?utf-8?B?d053M1ZDZDR3TG55NUZvblpLcU1tWHZCU1VFYnNGbUwzMkh0NUVVa1p2QkNy?=
 =?utf-8?B?QTJuSFN5clJRM2dnK24xMm1UMWRjb3Y5NXdyaFF6MEcwZzIrZXVNamZXVUZt?=
 =?utf-8?B?WDhhMVRJem5oSW5oMFg5UzVONFUrMCtpbGYrNS9nRmVLUitJSnh3clhhNU5p?=
 =?utf-8?B?RTE4RnlML3BkR1J4RnFZTkZKKy9OTWZBbzZxVlhlYnpkb2hRaC9NSUtMWVBu?=
 =?utf-8?B?SXVXc3N4dnFtMmQ4ZVpoNUdLMHF0eGt0ZllmRWdjMkMzc3RjY0x3SGhrdU9k?=
 =?utf-8?B?SXVXRFBJdVdDZDlqRHBRNUxpbEZvblZ1TFJlWUErdlJIYkEyV2FLaGU3dCtP?=
 =?utf-8?B?YW15TXorWmxQdmpNSjVSc0RaSlhJazZUbmdvM0JiaE9MdVB2RUxQSDhKK2FQ?=
 =?utf-8?B?dXhPUStkMWlRcGtjRTY4UVI2dDBkZGMvY0FpbzZIQXVZT0lFaFMrUlJFblJy?=
 =?utf-8?B?dWdQRmJlb25XOGpxeDJTQnhPNEgyMlBIVTFsMkhHVnhoeEROLzZHcDU1TS9i?=
 =?utf-8?B?S1czcUd5Vm5BNmUrRHRlODB6TS9US01EY0tUQnhZNjFEZ25CcDRvSmpoR0xl?=
 =?utf-8?B?enBSbFdCckQ0bXh2bzYvUENrRkIyRUg2U3B1QUJkSnd1eE52OHNQblpQQy9s?=
 =?utf-8?B?YlgxVC9TbjZOdnhFS2lhNjdNeFJuVFBIVVltMmU0VDlrMDJnSHBSN09GVEFW?=
 =?utf-8?Q?DphrQwg0KU3Rk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9221b2f4-f0a5-4c8c-0352-08d9250beab7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 14:45:36.5254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsKsG2tfFqDPYlau2o/1Lfs/wnpIrGFplRX7dMo6KNGD8R086rKA0HRMJc5eDSZ7YCCbHbpFrYP/ktMddL7W9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562
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

Ck9uIDIwMjEtMDYtMDEgMzowNSBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDAx
LjA2LjIxIHVtIDAyOjA2IHNjaHJpZWIgRXJpYyBIdWFuZzoKPj4gV2l0aCBYR01JIGNvbm5lY3Rp
b24gZmx1c2hpbmcgSERQIG9uIFBDSWUgaXMgdW5uZWNlc3NhcnksCj4+IGl0IGlzIGFsc28gdG8g
b3B0aW1pemUgbWVtb3J5IGFsbG9jYXRpb24gbGF0ZW5jeS4KPj4KPj4gU2lnbmVkLW9mZi1ieTog
RXJpYyBIdWFuZyA8amluaHVpZXJpYy5odWFuZ0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2hkcC5oIHwgMSArCj4+IMKgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jwqAgfCAzICsrLQo+PiDCoCBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jwqDCoCB8IDEgKwo+PiDCoCBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9oZHBfdjRfMC5jwqDCoCB8IDMgKysrCj4+IMKgIDQgZmlsZXMgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaGRwLmggCj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2hkcC5oCj4+IGluZGV4IDdlYzk5ZDU5MTU4NC4uMWNhMjNmMmY1MWQy
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaGRwLmgK
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2hkcC5oCj4+IEBAIC00
NCw2ICs0NCw3IEBAIHN0cnVjdCBhbWRncHVfaGRwIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgcmFz
X2NvbW1vbl9pZsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnJhc19pZjsKPj4gwqDCoMKgwqDCoCBj
b25zdCBzdHJ1Y3QgYW1kZ3B1X2hkcF9mdW5jc8KgwqDCoMKgwqDCoMKgICpmdW5jczsKPj4gwqDC
oMKgwqDCoCBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2hkcF9yYXNfZnVuY3PCoMKgwqAgKnJhc19mdW5j
czsKPj4gK8KgwqDCoCBib29swqDCoMKgIG5vX2ZsdXNoOwo+PiDCoCB9Owo+PiDCoCDCoCBpbnQg
YW1kZ3B1X2hkcF9yYXNfbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jIAo+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4+IGluZGV4IGFhYTI1NzRj
ZTliYy4uZjMxZWFlMjkzMWYzIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfaWIuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfaWIuYwo+PiBAQCAtMjI2LDcgKzIyNiw4IEBAIGludCBhbWRncHVfaWJfc2NoZWR1bGUoc3Ry
dWN0IGFtZGdwdV9yaW5nICpyaW5nLCAKPj4gdW5zaWduZWQgbnVtX2licywKPj4gwqDCoMKgwqDC
oCBpZiAoIShhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpKQo+PiDCoCAjZW5kaWYKPj4gwqDCoMKg
wqDCoCB7Cj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAocmluZy0+ZnVuY3MtPmVtaXRfaGRwX2ZsdXNo
KQo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHJpbmctPmZ1bmNzLT5lbWl0X2hkcF9mbHVzaCAmJgo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAhYWRldi0+aGRwLm5vX2ZsdXNoKQo+Cj4gVGhpcyBz
dGlsbCBlbWl0cyB0aGUgZmx1c2ggdGhyb3VnaCBNTUlPLgoKQXMgbWF0dGVyIG9mIGZhY3QsIGl0
IGRvZXNuJ3QsIGJlY2F1c2UgYW1kZ3B1X2FzaWNfZmx1c2hfaGRwIHdpbGwgY2hlY2sgCnRoZSBm
bGFnIGFnYWluIGluIGhkcF92NF8wLmMuIEkgZXZlbiB0aGluayB0aGUgY2hlY2sgaGVyZSBpcyB1
bm5lY2Vzc2FyeSAKZm9yIHByZXZpb3VzIGFzaWMsIGJlY2F1c2UgYXNpYyBvdGhlciB0aGFuIEFs
ZGViZXJhbiBBK0EgaGFzIHRvIGZsdXNoIAp0bGJzIGFjY29yZGluZyB0byBoYXJkd2FyZSBzcGVj
aWZpYy4KPgo+IFdoYXQgeW91IG5lZWQgdG8gZG8gaXMgdG8gaW5pdGlhbGl6ZSB0aGUgaGRwLm5v
X2ZsdXNoIGZpZWxkIGZvciBhbGwgCj4gYXNpY3MgYW5kIGFyY2hpdGVjdHVyZXMgYW5kIHRoZW4g
dXNlIHRoYXQgaGVyZSBpbiB0aGUgaWYgYWJvdmUgdGhpcyBvbmUuCgpJIGRvbid0IHVuZGVyc3Rh
bmQgd2h5IGl0IHNob3VsZCBiZSBmb3IgYWxsIGFzaWNzLiBDdXJyZW50bHkgb25seSAKQWxkZWJl
cmFuIEErQSBuZWVkIG5vIFRMQiBmbHVzaCwgd2UgZG9uJ3QgaGF2ZSB0byBjb25zaWRlciBvdGhl
ciBhc2ljcy4gCkFuZCBoZHAubm9fZmx1c2ggaXMgYSBjb21tb24gZmxhZyBmb3IgYWxsIGFzaWNz
LCBJcyB0aGVyZSBhbiBpc3N1ZSBpbiAKb3RoZXIgYXNpY3MgZm9yIHRoaXMgZmxhZyBvbiB0bGIg
Zmx1c2g/Cj4KPj4gYW1kZ3B1X3JpbmdfZW1pdF9oZHBfZmx1c2gocmluZyk7Cj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBlbHNlCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9hc2lj
X2ZsdXNoX2hkcChhZGV2LCByaW5nKTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192OV8wLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y5XzAuYwo+PiBpbmRleCAyNzQ5NjIxZDVmNjMuLjZlMWVhYjYxNTkxNCAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4+IEBAIC0xMjIzLDYgKzEyMjMsNyBAQCBz
dGF0aWMgaW50IGdtY192OV8wX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgYWRldi0+Z21jLnhnbWkuc3VwcG9ydGVkID0gdHJ1ZTsKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIGFkZXYtPmdtYy54Z21pLmNvbm5lY3RlZF90b19jcHUgPQo+PiBhZGV2LT5zbXVpby5m
dW5jcy0+aXNfaG9zdF9ncHVfeGdtaV9zdXBwb3J0ZWQoYWRldik7Cj4+ICvCoMKgwqDCoMKgwqDC
oCBhZGV2LT5oZHAubm9fZmx1c2ggPSBhZGV2LT5nbWMueGdtaS5jb25uZWN0ZWRfdG9fY3B1Owo+
PiDCoMKgwqDCoMKgIH0KPj4gwqAgwqDCoMKgwqDCoCBnbWNfdjlfMF9zZXRfZ21jX2Z1bmNzKGFk
ZXYpOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaGRwX3Y0XzAu
YyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9oZHBfdjRfMC5jCj4+IGluZGV4IDc0
YjkwY2MyYmY0OC4uZTFiMmZhY2U4NjU2IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9oZHBfdjRfMC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2hkcF92NF8wLmMKPj4gQEAgLTQwLDYgKzQwLDkgQEAKPj4gwqAgc3RhdGljIHZvaWQgaGRwX3Y0
XzBfZmx1c2hfaGRwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPj4gwqAgewo+
PiArwqDCoMKgIGlmIChhZGV2LT5oZHAubm9fZmx1c2gpCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1
cm47Cj4+ICsKPgo+IEp1c3QgdG8gYmUgY2xlYXIgb25jZSBtb3JlLCB0aGlzIGFwcHJvYWNoIGlz
IGEgTkFLLgo+Cj4gQ2hlY2tzIGxpa2UgdGhpcyBzaG91bGQgbm90IGJlIGluIHRoZSBoYXJkd2Fy
ZSBzcGVjaWZpYyBmdW5jdGlvbi4KCkFzIEkgbWVudGlvbiBhYm92ZSwgVExCIGZsdXNoIHNob3Vs
ZCBiZSBzcGVjaWZpYyBmb3IgQXNpYyBmb3IgbXkgb3Bpbmlvbi4KClJlZ2FyZHMsCkVyaWMKPgo+
IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+IMKgwqDCoMKgwqAgaWYgKCFyaW5nIHx8ICFyaW5n
LT5mdW5jcy0+ZW1pdF93cmVnKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgV1JFRzMyX05PX0tJUSgo
YWRldi0+cm1taW9fcmVtYXAucmVnX29mZnNldCArIAo+PiBLRkRfTU1JT19SRU1BUF9IRFBfTUVN
X0ZMVVNIX0NOVEwpID4+IDIsIDApOwo+PiDCoMKgwqDCoMKgIGVsc2UKPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
