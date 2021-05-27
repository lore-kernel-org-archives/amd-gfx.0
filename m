Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53FCC4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 09:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966B9613E2
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 09:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966B9613E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF6D6EE4E;
	Thu, 27 May 2021 09:42:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B97026EE4E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 09:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWB56hgV5XYsnfkg2E12ku60IBw/LZ22BiWv5lZ6OysZG8rAvCKrE01PjG1llxIY+6qbw5zI/y2zoKsrUgs9KYixWzQ5x2D62DRJbT9QNdUoqrh5FYEt4kZS79xtBrrtTeTV39x8HxLGOIEA7F/FAJngsw/+u+2KNaS8npURTzC03uUI6Qmr12VEuY+Bk/4I58PosnyJW+cUgcX+7Z1bX/7hw01QAQVqLplQJJS8j5ZJYj5Xvvx59ds7Hy2Vfjg/CcYbIjlIgKu8B/T4BIlavsxsvcN6bv9K013SMgaL2iGa4QTZJVd5iwY5sTagUq0DCa+3VXyGmrGBcaNCPbPqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LirohyScRKb+JUo/Lg/I7XjET1vWR+iKP08RqUcvKUQ=;
 b=dc8WG8D5C1aGnUI5ii5jrvpVz8nrZ6/gNn1pEKNAOfhn3VNm8iELwc8edEj/Ofjot2ZB/gWolmg/SkZQ3DpKpsoQlQKN9ATOMDl/jh+OAKhIOD0Hz6ZGz56kpbVXwXgrkZZ/g6kS3VY47cxaMm+nQ7u/fA1UhEn5Wk+5owlDnQizhOoNqGitz/9NYSTb85sfLs1y+JHNxvhw+IpCZA3517tg0jQ9J+8qDZuKxf48FbxQM77yG+Xbir8cb97/VDsXPJP0pWnxM3lfXFjHy8S4H4AdaqxBb/OpGQ9CYIal54BX0m7i0C8xSACRzbFAeCQr/WrfZGpzjb3G5VQwRkXkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LirohyScRKb+JUo/Lg/I7XjET1vWR+iKP08RqUcvKUQ=;
 b=NZxjERZfjEf930GpUVMBW/TnvwRKl4Ia0j5XMvSAeMurlpBsb0FAUyGFotrdVikXf6jLoF/8QPFDiPcEXmMRWJ3eQ6Mwj3NSrqDD72Z47vDHJxzbRrh5epnKyEz8qrqh10y8wYidunO+FPR7e6GGiZDD3+xxzNu3vwEfbtMAaZs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4782.namprd12.prod.outlook.com (2603:10b6:208:a3::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 09:42:24 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.024; Thu, 27 May 2021
 09:42:24 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error
 counters
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210526164316.20547-1-luben.tuikov@amd.com>
 <20210526164316.20547-3-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b712276e-6afd-b8f5-89c1-23ae41abac0f@amd.com>
Date: Thu, 27 May 2021 11:42:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210526164316.20547-3-luben.tuikov@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:df77:ce75:29f4:b9ab]
X-ClientProxiedBy: AM0P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::40) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:df77:ce75:29f4:b9ab]
 (2a02:908:1252:fb60:df77:ce75:29f4:b9ab) by
 AM0P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21 via Frontend Transport; Thu, 27 May 2021 09:42:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 844d08e5-c383-45b7-58c3-08d920f3bab3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4782:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB478200E61E810560E5B9702F83239@MN2PR12MB4782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CChfZbV6Z0dEJk7xM9LJfdf5GtKwTtl9xNH/DPGVx4KQHM3olbInvOzFb91C4MiSQs2qJyghUJIXNhx2+CduCGId1O7WFC0h50/n+yAYijAWvfUCBcDSdIr3o9ng7Awp7uZaMGuIs/c+mPWgKPpTXnxmWduZFCh/DJF187t5z0eaR/6qJC0Wc+5Q33+1SBRtSYFpt8qQw55lmxbZvwwZrtD3QImJ9HluELqJod8Ly0aB91g5f3HGMugr7VvJBDMx1GoNGuUhzuoaWqjryAfDpaT4eCQrpgtwgBGNmadxdaf1+Gws+X1IMuh+eRHf2GD/yj7rISN1ZfBjWk5q6MqQDumSTb75v8yvt8S5uY7NmQ9tGJm3sisMOJQtYpNkV5/CEpgOGrjjI661oknP+YV+xKu61c5LPkTOi+emouCC/1ZtEfzQhexwsWP3XB5LhkkLD1OuDI88pCPVhO2JB+54o22r7OFTAltEGwzC4J7HYDOoCtkuKDClQgvQWTM9vGBCtF4Jznrh782z5ERyTnIU1SKev5YXcknWOfT46+pTTifWNt6r4yi/qWSD7NOTO2YWjKNcy3JWkvZzmIXyk3/QTv8RrH/e1FfoLSkKprHKoXslrktRq0K8exvAvvjZsDICgof8iXxoecESazZrFfsUS8JLtemrr0XHfpHph5TJnMkgh33Up9jzeb+kmKriZMie
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(4326008)(2616005)(8676002)(6666004)(31696002)(66476007)(66556008)(66574015)(66946007)(83380400001)(86362001)(52116002)(478600001)(38100700002)(5660300002)(36756003)(31686004)(186003)(16526019)(2906002)(8936002)(6486002)(54906003)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UkNSY0FkWERJQnRleWRpMEUwNFFWc2JIeXZRSG8wNEpTblltWGt0WkkwZCtG?=
 =?utf-8?B?Q1NsK1c5d1JGdE9WUmNYSU14bi80OEUrcHF4RmdwZ3JvQUFtM2JHWFUxUlI2?=
 =?utf-8?B?cC9iTGJEc3lsRDlVRjFkL3JIT3V0KzhqWS9YQU1jWlQ5ZlVHNk9lUEdjbG1T?=
 =?utf-8?B?ZElldXYrdHUyeDlub2hTSG1sOFdYQlJNdnhDYnpsMGxFaXdwSERUUmoydEM4?=
 =?utf-8?B?YXhSN0x2RHMzMmRIZ3QvVm53YjVVWlNoWE5ZcTlKd1ROSFRRcmJ6Wi9FREpZ?=
 =?utf-8?B?eklmMnE4L3NrNWVKL0V4ZlNNWXlRZGNaWlc5SzhlSlFTN0ZsNTFuRE1FWDdq?=
 =?utf-8?B?dGdYd3pBUXArby9yMDRJaTllanJqK3VxM3Q2clptMkV1TEk5V050ZHR2OGxC?=
 =?utf-8?B?ZmYyRE5UTXhsVG53NENQYTNnMWwrSWI1TDc4b2drLzlBWkxBY1hHMWFXSjJB?=
 =?utf-8?B?RTBZU0pRSXowTDVYd1R6RVhjaFZEMmVuMVM2OXUwMHl1OWRBcU1pNXZXdGtB?=
 =?utf-8?B?d2VkdnRRVk81dUxWa25BdC9SREZTY2FZUm9SNktKVFBXVk9jeVd3YjRKcHo4?=
 =?utf-8?B?RE1KelN2TERvSlRVNkRMMHRsVEEzNlBqM0ZZbkNabjNOWUEvelo1d00wTnJq?=
 =?utf-8?B?NXVoRGljZTZGVEkvTEZGZXI0djRhc0ttU204QzBseGNURkJ1L3o3RktUcFNU?=
 =?utf-8?B?REFXbnpycXhkSG0yejJnMEgrczc1Syt4dGNQMFZkcFpzTGo1T3BqeUlOOXNs?=
 =?utf-8?B?cFpEMmJhMzEyckt0czJ6WWV2M0hhOUtsblhMRGZReStXbWg5RHNJUUpyVkM0?=
 =?utf-8?B?MkIraHY4bldoMW1ucW5ja3dVbkU4VDUwME9TTm5aOVlMSGxIVHNLZnd4MVNY?=
 =?utf-8?B?anlVVUpLRXVQa2VRcTFZOWlYSFhvOHFFT1RNZzhmZ2gydnRvTzA4anZ0NnRR?=
 =?utf-8?B?ZEExNmg0MnhaeEFDZDBsa1NiZXRpV0RyZFVNVkdUc2lDSEwwYmdyeFNYL2Z1?=
 =?utf-8?B?b0o1Z2NuV3dSSC9SREpNMnhJZDF0MG9sR01hM1IvS24xQXpmRzgrYTlHUWx2?=
 =?utf-8?B?Q2l6YnhXb1JsRUNYdDVhbk5GS3JvcHBZaVlqSm9GdllaN3dhTGFJOTJ0cDVF?=
 =?utf-8?B?d3UramYxYS9xeERZTXpCWW5IVkFLRGJzWGIyb1o2SlJxclk1WkRpNE5jMHVZ?=
 =?utf-8?B?OE9YanVjZ0JqOW80eUJsWGRLa1ZCTktDdUtjK2hhelpaZjdyZGZOb1h2U1kz?=
 =?utf-8?B?NGJYRGpCaC9aMzRMc0o1d0lwRWVIKzczVmlxWDdNMkVEQUlXYnJ2OTZ5Yi94?=
 =?utf-8?B?Uk53bnB5emhsUFhaZ2VONWlObDRzOU9MWlkvWi9sQVRVYmdTaVpYeVJVRFo2?=
 =?utf-8?B?bDM0TWRGOXFLZ2F3Z0xXayszNC9IdnZGcnpLcFJSQmNLRWpMK0dibUl5OHBP?=
 =?utf-8?B?NEJPZlNMRElMYVV5STdtQlUxRkJiNGM2eGdZNjFyUTV6Z2hRT0kxL2M2OUZl?=
 =?utf-8?B?czI3VVdRMmYrRU9TZjNOUDV4Nmk1dHp3MjdRcDF5YVN6Q2x1UDRjM01DbGFJ?=
 =?utf-8?B?OXdMdkFXVU4zbTUzSVU1U3JKbVpKS3NEY01yLzZXUERhM0MzZlBEa29JNDB2?=
 =?utf-8?B?c2ZUeE1qN05JbDFoRXA5K0ROUnFDaFM2cEVZM2xwNWxob05ub1VBK3Z3USs1?=
 =?utf-8?B?T1Y5YXFDSWJnZS93VDY2UXZHcThUSXJiSzdNNjFkQ005T29XK051dDV0YzRC?=
 =?utf-8?B?bVV2RnhXTzNJQXh0YUlnTCtDQ09QdkdrbldjSVZjZmJpTXEzaUVwK1J3NHhz?=
 =?utf-8?B?eVA5eFp6TkZ6dkVIT2c4eUV1N3pQRlN3T1pkNEh1VkVjdWtFOEZBM05ueHRK?=
 =?utf-8?Q?RNGqAN3n7Dn43?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844d08e5-c383-45b7-58c3-08d920f3bab3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 09:42:23.4361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzAVtX6VXywXeEzFDDHFQwcN4HfRqBYJ75//l07Q7Vi73uQ3fKc819nqV7jnydUL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4782
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjYuMDUuMjEgdW0gMTg6NDMgc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4gT24gQ29udGV4dCBR
dWVyeTIgSU9DVEwgcmV0dXJuIHRoZSBjb3JyZWN0YWJsZSBhbmQKPiB1bmNvcnJlY3RhYmxlIGVy
cm9ycyBpbiBPKDEpIGZhc2hpb24sIGZyb20gY2FjaGVkCj4gdmFsdWVzLCBhbmQgc2NoZWR1bGUg
YSBkZWxheWVkIHdvcmsgZnVuY3Rpb24gdG8KPiBjYWxjdWxhdGUgYW5kIGNhY2hlIHRoZW0gZm9y
IHRoZSBuZXh0IHN1Y2ggSU9DVEwuCj4KPiB2MjogQ2FuY2VsIHBlbmRpbmcgZGVsYXllZCB3b3Jr
IGF0IHJhc19maW5pKCkuCj4gdjM6IFJlbW92ZSBjb25kaXRpb25hbHMgd2hlbiBkZWFsaW5nIHdp
dGggZGVsYXllZAo+ICAgICAgd29yayBtYW5pcHVsYXRpb24gYXMgdGhleSdyZSBpbmhlcmVudGx5
IHJhY3kuCj4KPiBDYzogQWxleGFuZGVyIERldWNoZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+Cj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBD
YzogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgo+IENjOiBIYXdraW5nIFpo
YW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTHViZW4gVHVpa292
IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2N0eC5jIHwgMzEgKysrKysrKysrKysrKysrKystLQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgNDAgKysrKysrKysrKysrKysrKysrKysr
KysrKwo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oIHwgIDUgKysr
Kwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+IGluZGV4IGJiMGNmZTg3
MWFiYS4uZTdhMDEwYjdjYTFmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9jdHguYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9jdHguYwo+IEBAIC0zMzEsMTAgKzMzMSwxMyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jdHhfcXVl
cnkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gICAK
PiArI2RlZmluZSBBTURHUFVfUkFTX0NPVU5URV9ERUxBWV9NUyAzMDAwCj4gKwo+ICAgc3RhdGlj
IGludCBhbWRncHVfY3R4X3F1ZXJ5MihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAtCXN0
cnVjdCBhbWRncHVfZnByaXYgKmZwcml2LCB1aW50MzJfdCBpZCwKPiAtCXVuaW9uIGRybV9hbWRn
cHVfY3R4X291dCAqb3V0KQo+ICsJCQkgICAgIHN0cnVjdCBhbWRncHVfZnByaXYgKmZwcml2LCB1
aW50MzJfdCBpZCwKPiArCQkJICAgICB1bmlvbiBkcm1fYW1kZ3B1X2N0eF9vdXQgKm91dCkKPiAg
IHsKPiArCXN0cnVjdCBhbWRncHVfcmFzICpjb24gPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFk
ZXYpOwo+ICAgCXN0cnVjdCBhbWRncHVfY3R4ICpjdHg7Cj4gICAJc3RydWN0IGFtZGdwdV9jdHhf
bWdyICptZ3I7Cj4gICAKPiBAQCAtMzYxLDYgKzM2NCwzMCBAQCBzdGF0aWMgaW50IGFtZGdwdV9j
dHhfcXVlcnkyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCWlmIChhdG9taWNfcmVh
ZCgmY3R4LT5ndWlsdHkpKQo+ICAgCQlvdXQtPnN0YXRlLmZsYWdzIHw9IEFNREdQVV9DVFhfUVVF
UlkyX0ZMQUdTX0dVSUxUWTsKPiAgIAo+ICsJaWYgKGFkZXYtPnJhc19lbmFibGVkICYmIGNvbikg
ewo+ICsJCS8qIFJldHVybiB0aGUgY2FjaGVkIHZhbHVlcyBpbiBPKDEpLAo+ICsJCSAqIGFuZCBz
Y2hlZHVsZSBkZWxheWVkIHdvcmsgdG8gY2FjaGUKPiArCQkgKiBuZXcgdmF1ZXMuCj4gKwkJICov
Cj4gKwkJaW50IGNlX2NvdW50LCB1ZV9jb3VudDsKPiArCj4gKwkJY2VfY291bnQgPSBhdG9taWNf
cmVhZCgmY29uLT5yYXNfY2VfY291bnQpOwo+ICsJCXVlX2NvdW50ID0gYXRvbWljX3JlYWQoJmNv
bi0+cmFzX3VlX2NvdW50KTsKPiArCj4gKwkJaWYgKGNlX2NvdW50ICE9IGN0eC0+cmFzX2NvdW50
ZXJfY2UpIHsKPiArCQkJY3R4LT5yYXNfY291bnRlcl9jZSA9IGNlX2NvdW50Owo+ICsJCQlvdXQt
PnN0YXRlLmZsYWdzIHw9IEFNREdQVV9DVFhfUVVFUlkyX0ZMQUdTX1JBU19DRTsKPiArCQl9Cj4g
Kwo+ICsJCWlmICh1ZV9jb3VudCAhPSBjdHgtPnJhc19jb3VudGVyX3VlKSB7Cj4gKwkJCWN0eC0+
cmFzX2NvdW50ZXJfdWUgPSB1ZV9jb3VudDsKPiArCQkJb3V0LT5zdGF0ZS5mbGFncyB8PSBBTURH
UFVfQ1RYX1FVRVJZMl9GTEFHU19SQVNfVUU7Cj4gKwkJfQo+ICsKPiArCQlzY2hlZHVsZV9kZWxh
eWVkX3dvcmsoJmNvbi0+cmFzX2NvdW50ZV9kZWxheV93b3JrLAo+ICsJCQkJICAgICAgbXNlY3Nf
dG9famlmZmllcyhBTURHUFVfUkFTX0NPVU5URV9ERUxBWV9NUykpOwo+ICsJfQo+ICsKPiAgIAlt
dXRleF91bmxvY2soJm1nci0+bG9jayk7Cj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+IGluZGV4IGVkM2M0M2U4YjBiNS4uZWM5MzZj
ZGUyNzI2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+IEBA
IC0yNyw2ICsyNyw3IEBACj4gICAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPgo+ICAgI2luY2x1
ZGUgPGxpbnV4L3JlYm9vdC5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3N5c2NhbGxzLmg+Cj4gKyNp
bmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+Cj4gICAKPiAgICNpbmNsdWRlICJhbWRncHUuaCIK
PiAgICNpbmNsdWRlICJhbWRncHVfcmFzLmgiCj4gQEAgLTIxMTYsNiArMjExNywzMCBAQCBzdGF0
aWMgdm9pZCBhbWRncHVfcmFzX2NoZWNrX3N1cHBvcnRlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKPiAgIAkJYWRldi0+cmFzX2h3X2VuYWJsZWQgJiBhbWRncHVfcmFzX21hc2s7Cj4gICB9
Cj4gICAKPiArc3RhdGljIHZvaWQgYW1kZ3B1X3Jhc19jb3VudGVfZHcoc3RydWN0IHdvcmtfc3Ry
dWN0ICp3b3JrKQo+ICt7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X3JhcyAqY29uID0gY29udGFpbmVyX29m
KHdvcmssIHN0cnVjdCBhbWRncHVfcmFzLAo+ICsJCQkJCSAgICAgIHJhc19jb3VudGVfZGVsYXlf
d29yay53b3JrKTsKPiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gY29uLT5hZGV2Owo+
ICsJc3RydWN0IGRybV9kZXZpY2UgKmRldiA9ICZhZGV2LT5kZGV2Owo+ICsJdW5zaWduZWQgbG9u
ZyBjZV9jb3VudCwgdWVfY291bnQ7Cj4gKwlpbnQgcmVzOwo+ICsKPiArCXJlcyA9IHBtX3J1bnRp
bWVfZ2V0X3N5bmMoZGV2LT5kZXYpOwo+ICsJaWYgKHJlcyA8IDApCj4gKwkJZ290byBPdXQ7Cj4g
Kwo+ICsJLyogQ2FjaGUgbmV3IHZhbHVlcy4KPiArCSAqLwo+ICsJYW1kZ3B1X3Jhc19xdWVyeV9l
cnJvcl9jb3VudChhZGV2LCAmY2VfY291bnQsICZ1ZV9jb3VudCk7Cj4gKwlhdG9taWNfc2V0KCZj
b24tPnJhc19jZV9jb3VudCwgY2VfY291bnQpOwo+ICsJYXRvbWljX3NldCgmY29uLT5yYXNfdWVf
Y291bnQsIHVlX2NvdW50KTsKPiArCj4gKwlwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGRldi0+
ZGV2KTsKPiArT3V0Ogo+ICsJcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoZGV2LT5kZXYpOwo+
ICt9Cj4gKwo+ICAgaW50IGFtZGdwdV9yYXNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKPiAgIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3JhcyAqY29uID0gYW1kZ3B1X3Jhc19nZXRfY29u
dGV4dChhZGV2KTsKPiBAQCAtMjEzMCw2ICsyMTU1LDExIEBAIGludCBhbWRncHVfcmFzX2luaXQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJaWYgKCFjb24pCj4gICAJCXJldHVybiAt
RU5PTUVNOwo+ICAgCj4gKwljb24tPmFkZXYgPSBhZGV2Owo+ICsJSU5JVF9ERUxBWUVEX1dPUkso
JmNvbi0+cmFzX2NvdW50ZV9kZWxheV93b3JrLCBhbWRncHVfcmFzX2NvdW50ZV9kdyk7Cj4gKwlh
dG9taWNfc2V0KCZjb24tPnJhc19jZV9jb3VudCwgMCk7Cj4gKwlhdG9taWNfc2V0KCZjb24tPnJh
c191ZV9jb3VudCwgMCk7Cj4gKwo+ICAgCWNvbi0+b2JqcyA9IChzdHJ1Y3QgcmFzX21hbmFnZXIg
KikoY29uICsgMSk7Cj4gICAKPiAgIAlhbWRncHVfcmFzX3NldF9jb250ZXh0KGFkZXYsIGNvbik7
Cj4gQEAgLTIyMzMsNiArMjI2Myw4IEBAIGludCBhbWRncHVfcmFzX2xhdGVfaW5pdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkJCSBzdHJ1Y3QgcmFzX2ZzX2lmICpmc19pbmZvLAo+
ICAgCQkJIHN0cnVjdCByYXNfaWhfaWYgKmloX2luZm8pCj4gICB7Cj4gKwlzdHJ1Y3QgYW1kZ3B1
X3JhcyAqY29uID0gYW1kZ3B1X3Jhc19nZXRfY29udGV4dChhZGV2KTsKPiArCXVuc2lnbmVkIGxv
bmcgdWVfY291bnQsIGNlX2NvdW50Owo+ICAgCWludCByOwo+ICAgCj4gICAJLyogZGlzYWJsZSBS
QVMgZmVhdHVyZSBwZXIgSVAgYmxvY2sgaWYgaXQgaXMgbm90IHN1cHBvcnRlZCAqLwo+IEBAIC0y
MjczLDYgKzIzMDUsMTIgQEAgaW50IGFtZGdwdV9yYXNfbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+ICAgCWlmIChyKQo+ICAgCQlnb3RvIHN5c2ZzOwo+ICAgCj4gKwkvKiBU
aG9zZSBhcmUgdGhlIGNhY2hlZCB2YWx1ZXMgYXQgaW5pdC4KPiArCSAqLwo+ICsJYW1kZ3B1X3Jh
c19xdWVyeV9lcnJvcl9jb3VudChhZGV2LCAmY2VfY291bnQsICZ1ZV9jb3VudCk7Cj4gKwlhdG9t
aWNfc2V0KCZjb24tPnJhc19jZV9jb3VudCwgY2VfY291bnQpOwo+ICsJYXRvbWljX3NldCgmY29u
LT5yYXNfdWVfY291bnQsIHVlX2NvdW50KTsKPiArCj4gICAJcmV0dXJuIDA7Cj4gICBjbGVhbnVw
Ogo+ICAgCWFtZGdwdV9yYXNfc3lzZnNfcmVtb3ZlKGFkZXYsIHJhc19ibG9jayk7Cj4gQEAgLTIz
OTAsNiArMjQyOCw4IEBAIGludCBhbWRncHVfcmFzX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCj4gICAJaWYgKGNvbi0+ZmVhdHVyZXMpCj4gICAJCWFtZGdwdV9yYXNfZGlzYWJsZV9h
bGxfZmVhdHVyZXMoYWRldiwgMSk7Cj4gICAKPiArCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygm
Y29uLT5yYXNfY291bnRlX2RlbGF5X3dvcmspOwo+ICsKPiAgIAlhbWRncHVfcmFzX3NldF9jb250
ZXh0KGFkZXYsIE5VTEwpOwo+ICAgCWtmcmVlKGNvbik7Cj4gICAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Jhcy5oCj4gaW5kZXggMTBmY2EwMzkzMTA2Li4yNTZjZWE1ZDM0ZjIg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oCj4gQEAgLTM0MCw2
ICszNDAsMTEgQEAgc3RydWN0IGFtZGdwdV9yYXMgewo+ICAgCj4gICAJLyogZGlzYWJsZSByYXMg
ZXJyb3IgY291bnQgaGFydmVzdCBpbiByZWNvdmVyeSAqLwo+ICAgCWJvb2wgZGlzYWJsZV9yYXNf
ZXJyX2NudF9oYXJ2ZXN0Owo+ICsKPiArCS8qIFJBUyBjb3VudCBlcnJvcnMgZGVsYXllZCB3b3Jr
ICovCj4gKwlzdHJ1Y3QgZGVsYXllZF93b3JrIHJhc19jb3VudGVfZGVsYXlfd29yazsKPiArCWF0
b21pY190IHJhc191ZV9jb3VudDsKPiArCWF0b21pY190IHJhc19jZV9jb3VudDsKPiAgIH07Cj4g
ICAKPiAgIHN0cnVjdCByYXNfZnNfZGF0YSB7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
