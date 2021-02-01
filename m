Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C72BC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD0964DD8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD0964DD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E37FB6E7E6;
	Mon,  1 Feb 2021 15:36:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36866E7E6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:36:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOMt6KsIYstMJ5HWDcy8Fz0rXrcCEEEobI/CxbhyZx6E/M6+gtGCPS277xWtUxSMKX/4JmM2lp6XT9JnDRozO/4vXOtE2IjamjVR9o8eUo5j5XmunD8n89UFAuNm5zXgheB/A1B5L80AswevUsfzSqRHkA2uCJHC/bQGOqv+w506iHVpJKKKt/bO1I2Z5szG/MZBQmO/zpwDHQpeCoQ4hXyJIpYYQ5U8HnhQxUnMOoBbMr7SFLIwoXtYhiAIP8tfh20bacUFxkbUp8sauDQoM88PAAC6nj+YLUTU9NcEQCXcXsHYJ+7i+fDqE0higl04tJvWkXR8+m9IQE0hIKyvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3UdSRa+1mlV9VGPa6G4TWm3spK+XjBuyUEM6Czj074=;
 b=kn8cEAWj3m5TeA8JFknSC672RQtP5/9J8O5Sgu7PcgJA8OOf2qW2fDrsp2pSSWUrGV5Rbipx4f6LLp8+NSJZf7LfplxGNW5X94fcviUqOErV69VAXjH9VnOPx56Qy/+E5+sOgTfo3Aj5qBWfXD7jiDLfICDXU/LhxWQ9yfkjhPRDeaQZ/MxkdDfiloTYOGK82aGv6n5QnJ3MPzIknfw8o1hwTYGy/NvOiwJmkOp3ZwbEVvhMM9xs7Onmec8G77pfxQWzXYv/QikKmtgjQd65QO5Syg+R3cZW9TqG+mCcXWPjiwkQ9LWAqrun3PGGnd/qjGiJjSJwigwZ1LSausEWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3UdSRa+1mlV9VGPa6G4TWm3spK+XjBuyUEM6Czj074=;
 b=RPryCORvG1SoBTFaUIMhibXnEafCOSNfAcVKm6ie6eojMEcN4P7IiHmGtJvRUtXFOIhPXMNbOFdIauYngnhObiJj8bf+hjTbJlM5xHdlX2DpbSm1GBNqZQkDT+FKOPkUYLgo97u7bN9RlglaFfIsiNKPdjhzQZo/vm3xMiUQpR4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4897.namprd12.prod.outlook.com (2603:10b6:208:17e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 15:36:16 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 15:36:16 +0000
Subject: Re: [PATCH v2 1/4] drm/amdgpu: cleanup ring priority assignment
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210201153320.59415-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6781579c-8aa9-4e54-cb74-2b1fd8d61a82@amd.com>
Date: Mon, 1 Feb 2021 16:36:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210201153320.59415-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM9P192CA0029.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM9P192CA0029.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 15:36:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e32e993-2e50-4a42-71c3-08d8c6c71d15
X-MS-TrafficTypeDiagnostic: BL0PR12MB4897:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB489796479F16FF2EC6FDEC1983B69@BL0PR12MB4897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8kDsZOJXY3SC3Fm6hSlTJF+cOM8rtdS9Xkuvvo9z53rSpCNnSyMC2RtZvRAhzcwTCnUytlSaYNczXQiI7zlsL+7fh/oY6S0vQO9G0qiwtHUyMKnatuD8OKbH93k3FxeQZ6BO8ZtJ03MhLpkA/lrEOWE5EZAqgYfY+FhtpWL4lONOOPl9rn6H3tvnHywHyE1uUzL+VRz6YUEmkg3T9bU1K+msGAoq+VWt/O/g88g8ETQfYrZ0iDFwajc0XeBysFwQj9AtratRuRm04yyrFsVownZwViMI0mdGb7hm/Ke5oKW8GaYdvDYW45yHcylfn1nMOkjHPPvVtVphtps11pvmgwjf7tVFJoftI7YcZj2VvfazC+qTjDC+DyCXzsOnJIB7ro6PQWvw7yFIoBCt5vfdSbvOw9+NO/GUpYcnqaqcIT72uotZF9ujcALeYslZ08eH3FzlTFGcKM5ks0EEVbJga1MYfFu80ytaTzhsrK1graFgBqFhqKeR/Dabe3Hl9KAXmENnidC5Z1PzaKAcR4DU6WCBevbR9mXqAm3fdd13sGCPNJ09og5nFFTCs3R9Z3FIUYzjYMuttkO9NaRYasuh2kW3kyC2xXzKhce1oQlg78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(6486002)(83380400001)(5660300002)(31696002)(36756003)(316002)(86362001)(52116002)(31686004)(2906002)(478600001)(6666004)(16526019)(186003)(8676002)(8936002)(66556008)(66946007)(2616005)(66476007)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N3NiTXVjWTNpVVNJdW5OZzlKSGRyclBGclpsT0RWVTE2bGpKdXpBSGxpb3BQ?=
 =?utf-8?B?TlFvZnRzL0xYVTJuNy90NGN0MU94MzRyTzNnSzh6VFhIQWJkVHgvbVJ2Zkxz?=
 =?utf-8?B?c0dId09ianluejZoMjBZSkhjWFZUTm5NOGhJZElxdXhxWVVuUjhsTG8rK0o2?=
 =?utf-8?B?czJkWWFMU1hKRjc4QVpwWWxSV2NWVmJHWUxuK0JjUjVXOVc1Y2RIYThyb2dn?=
 =?utf-8?B?UExQSHFjbE9UM25nUWJEdmxSTDk2YVpKdDB2emVrZWRnOWV3MGN6dzcyekpr?=
 =?utf-8?B?QXVvdTdKeTlWNVFUZlo4cDh2QmNyRzd2RlIzQXladkdFNU40eHVuUHBkOXY5?=
 =?utf-8?B?S2tyeEoxZkM5RTJwZit4OHBnR1NGOEVjZ0lXbEZlOEFFQjZRVmdLc2tjTVpU?=
 =?utf-8?B?MHhxaFEzYS9JWTltMVlWbVRyNE4xclMxaVJwQm1Uc2ZLT2ZjVGJsaEY4NHli?=
 =?utf-8?B?U3lDR0l2L3VmQnhTd0xuc2FqL3k1a2JvSzlBU0ViSUdJeG04V1R5UEZrdGVN?=
 =?utf-8?B?K0pvaGg3L3QxWlZGeXN0VXE1TSs2bU9yd1lHblNqZlg5bmV5WUdpWWpEMzkw?=
 =?utf-8?B?TGFyRzYyWnRLdStzbnB1REpMd2lvYzByL3dQbVlMU1Y4Mng1OHNZbHIybGhP?=
 =?utf-8?B?THIzL3V0TmUyTUZCbWdxdlBYcDR5Zy9xTklHVzlaVmNuZU9RUG5PQ2FIdTVs?=
 =?utf-8?B?NU9ST2ViSnBJQ05jNmtJS0FYS2dXQXFXUjN1VndqTTlObDRaR1JnT2lmeFRQ?=
 =?utf-8?B?R0VRREZqN2h1VWhtTUdid3VqV3RYcHpjL096T0k1K2pKMFhyWWdrbkExd2xt?=
 =?utf-8?B?Y2I4ZThrOTJXWDN1cFArOHhaRjRnK09ieDhjVWJTWjhUWmpsQXhST3N6STd2?=
 =?utf-8?B?bXgwbThTdXZnL1dsY0hhL3VISlorSHExN0lJZHphMWNQS1JKMXJoYmFlTG5S?=
 =?utf-8?B?cVZEckFuazU0bkUvUitUTDZiaUpSQTZFZnpRU3drT0VTU1RBRmVQdTNhMHpn?=
 =?utf-8?B?VzFsblAxVnRJWjFVSjgrQ1dvUnlIRVBtSjloUzhHamtWdUxDVjRXUlFwT3dP?=
 =?utf-8?B?KytQaUtBRUtyYnNHMjZGaSswQXdlL3BTUmc2RHhnZyt2dzBPMnlGVFoyaHdX?=
 =?utf-8?B?U0FxVUVINFlnYXRrblhoUDVzalFySEhIUlIxaFlHSmxsWnVkVjNudlR0aXln?=
 =?utf-8?B?aDMrWFZjTVhWeElDUFJLYmo5aHEvd1IvZm1wckhzTWdFYUJZYW42ZlRaWWQ2?=
 =?utf-8?B?ZDdDOExOWnpMK0xLRnRlWmlickR5eHR0dWVNRXR0aDIwczFtQnFPUjJvc2Iv?=
 =?utf-8?B?QmhDWVdUeXo4blFYSWtleWZoWGlaaUMrMlZHTmo2MFZVQjNxbVlyMXUxbHM1?=
 =?utf-8?B?eGpObUNHUSsyOXRpVVgyYzJ6UVZJZEdZVFF4aVpZc0VvZGx0NWlNZE5RUjVs?=
 =?utf-8?B?NlhqK3RZbEo5aWNReVhUcnRUYUhKay9CTUJaWVlsczV3ZzRycWJweFVBSlpB?=
 =?utf-8?Q?4CZRTLILwCT0hjDREcl7dUdP2qg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e32e993-2e50-4a42-71c3-08d8c6c71d15
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:36:16.2950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFe1U/BCAkTfGfULPf4crQ8b4LEwKPDCAR8yfKDUkc3CdGCQM/OMschu3aDepqYo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4897
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
Cc: Alexander.Deucher@amd.com, Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 ray.huang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDEuMDIuMjEgdW0gMTY6MzMgc2NocmllYiBOaXJtb3kgRGFzOgo+IEFzc2lnbiBjb3JyZWN0
IGh3IHByaW9yaXR5IGZvciBjb21wdXRlIHJpbmcuIEFsc28gd2UgYXNzaWduCj4gcmluZyBwcmlv
cml0eSBhdCByaW5nIGluaXRpYWxpemF0aW9uIGFuZCBpdCByZW1haW5zIHVuY2hhbmdlZCwKPiBz
byB3ZSBkb24ndCBuZWVkIHJpbmctPnByaW9yaXR5X211dGV4IGFueW1vcmUuCj4KPiB2MjogcmVt
b3ZlIHJpbmctPnByaW9yaXR5X211dGV4Lgo+Cj4gRml4ZXM6IDMzYWJjYjFmNWExNyAoImRybS9h
bWRncHU6IHNldCBjb21wdXRlIHF1ZXVlIHByaW9yaXR5IGF0IG1xZF9pbml0IikKPiBTaWduZWQt
b2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jIHwgMyArLS0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmggfCAzICstLQo+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yaW5nLmMKPiBpbmRleCAxYTYxMmY1MWVjZDkuLmM0NWQ5YTNmMzc4ZSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYwo+IEBAIC0yNTgs
OCArMjU4LDcgQEAgaW50IGFtZGdwdV9yaW5nX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPiAgIAl9Cj4KPiAgIAlyaW5nLT5tYXhfZHcg
PSBtYXhfZHc7Cj4gLQlyaW5nLT5wcmlvcml0eSA9IERSTV9TQ0hFRF9QUklPUklUWV9OT1JNQUw7
Cj4gLQltdXRleF9pbml0KCZyaW5nLT5wcmlvcml0eV9tdXRleCk7Cj4gKwlyaW5nLT5wcmlvcml0
eSA9IGh3X3ByaW87Cj4KPiAgIAlpZiAoIXJpbmctPm5vX3NjaGVkdWxlcikgewo+ICAgCQlod19p
cCA9IHJpbmctPmZ1bmNzLT50eXBlOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmluZy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3JpbmcuaAo+IGluZGV4IDcxMTIxMzc2ODlkYi4uYTgzMTAwM2MyZDUzIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCj4gQEAgLTI0NCw4ICsyNDQsNyBAQCBz
dHJ1Y3QgYW1kZ3B1X3Jpbmcgewo+ICAgCWJvb2wJCQlub19zY2hlZHVsZXI7Cj4KPiAgIAlhdG9t
aWNfdAkJbnVtX2pvYnNbRFJNX1NDSEVEX1BSSU9SSVRZX0NPVU5UXTsKCm51bV9qb2JzIGNhbiBi
ZSByZW1vdmVkIGFzIHdlbGwuCgo+IC0Jc3RydWN0IG11dGV4CQlwcmlvcml0eV9tdXRleDsKPiAt
CS8qIHByb3RlY3RlZCBieSBwcmlvcml0eV9tdXRleCAqLwo+ICsKPiAgIAlpbnQJCQlwcmlvcml0
eTsKCk1heWJlIHJlbmFtZSBpdCB0byBod19wcmlvIGFuZCBtYWtlIGl0IGFuIHVuc2lnbmVkIGlu
dC4KCldpdGggdGhhdCBmaXhlZCBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgoKQ2hyaXN0aWFuLgoKPgo+ICAgI2lmIGRlZmluZWQoQ09ORklH
X0RFQlVHX0ZTKQo+IC0tCj4gMi4zMC4wCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
