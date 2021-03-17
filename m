Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9ADC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 15:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DDB64E12
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 15:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DDB64E12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0CA6E5C0;
	Wed, 17 Mar 2021 15:00:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 179C86E5BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 15:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G68StxRDD3yTyXYLGjlb18oP7EKwtIkO/QlooG/P/P0bFcw89hIe9Uw0JowRlGd/KeoOMX2sKh1dsnPyI/8RbamNO4rAJS43Lal6NJYHVJajPUKDqKPbJ0xi0oII2NoEeKXi/B7a3dryByix1y86PWw9ZDH/5XdoUqckZ4eUr3VOgIV7qoiEUfVx+MtJuYgt8awVhIB/LeG9nQkuoG66x2LIIJiLE4m5daI3/WV3XT1Jxv+a+EDJPw6jRJQt3mHW1OLnncTHdIawFHoyA0Vn/RE9u7wsGjGW7CjyGhsi+9BtEniAq/Jl9y23n+Kmj8fuZWfxEJ29Ow+2vIqshZNX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pPE2ekJo6BCDeRFtq+Wgf9EVfGsXhF54UQb644G1Y4=;
 b=MbQPLyz/cFeVsE29mY5kS93AG1tO0zTIj4PehR69mc4vQnzKvHcVF5wDXFKxnJmalJs2F0YIuofqKl5nT9/Wg5LFJFpXrcTJRseatA5/6/V4+e2DPuvn4d6NXu3yZO8nhWEIFTs8J+I79MiJhlsk5TcHduyhMeIbF33X1/PNGEVMqGlprAQzX7PpYcNwQOOndEoeU71JhAXFXCUbRN8ITJLwgZ/MqKILVrR946jEQgXkZDvsAfjZMLt6ETzPRe74CDxgA6UCB6zfOz6LfJJBgIdkabjFY0X3ZAUD6nGSCng0h4Q54OxdJaJ6tfWWuOLtBaFauyFxYIxzqyU090eQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pPE2ekJo6BCDeRFtq+Wgf9EVfGsXhF54UQb644G1Y4=;
 b=010re+kUOlxhoVTO2pJyytwN6yYDfA2ww4YKghjUbaDMxusLgDPU3YegvEh0Pke2jY/J7M/6FzWfwphE11yCn0uBtxYjBjEoOCW/UE0XUZdvmQFUuzjWRpIgQNBubVhwSEJra86Q36UEMLG9kIepzmHLKEENJQvs5Q/6V9qfXqY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3887.namprd12.prod.outlook.com (2603:10b6:208:168::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 15:00:32 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 15:00:32 +0000
Subject: Re: [PATCH V2] radeon: use kvcalloc for relocs and chunks
To: Chen Li <chenli@uniontech.com>, amd-gfx@lists.freedesktop.org
References: <87wnu5eszm.wl-chenli@uniontech.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1789545b-7a74-1fa7-4024-d0b4ebc88261@amd.com>
Date: Wed, 17 Mar 2021 16:00:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <87wnu5eszm.wl-chenli@uniontech.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
X-ClientProxiedBy: AM4P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::27) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
 (2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5) by
 AM4P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 15:00:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd487a29-17e4-484b-9c38-08d8e9556913
X-MS-TrafficTypeDiagnostic: MN2PR12MB3887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38870B54EDB18B3AD8BD1338836A9@MN2PR12MB3887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jea20DvHjM6yoKuo7JrCpEFNLCKfZANRnAeXd+EIzSGJQAf9+roQOZtEcZxcIzC51QYvCSmg0ulG3qp6lGfToOICRWtFF7f2Eb0dfLkzLyEousXBTl3YZYZyJqeUm2WbnCGClSKDZk7BaRKEk+ZRPYAt/NNi/IaBHG1hkh/yxkW2e0JtKwsAuuUxrpwU+hx8l9SBBc3jHnu0orTwVdJmQp+56huEvWyNEYFpAkGUoQVOOwMfu6k7j1rUtC59DMxqZbl8rEgdWzHGTLOqEvV0PpS2g38e0w7KulKJQ2NuNEZpJQxtByDWxqzAhvRrRfSXGTFxXT7KlUFUq7heZangWTjwHkOhRA7N9dKQtKTjtl9lopKo+mT/YO4rUMewLcoRIRSzzGaWgaeewI8z7plFIluHF1ZxOCfa0KzQMQU63cJ+2FJ6eOtT8g/IKqZLMYz+zn58oO8Mdk6ZjgfPepQfEhKmOxm1CI8JMU8qYAcPJYzi7X362GF5UJVo8N7+GUVvTBsiOzxVTCtChRUnQP8nlW8iTv8SFdOKW6AxdyfEe4g/dhN+tcoQ+ghJAxFuADyKHoeSrNmqTvJdzPLedqxdpIAmVDrTzcQ3vn0JRjHzw6wv/taktr+EigIY8pBZM4WpsA5fk8sUriZXIdQBz3CqBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(66574015)(8936002)(8676002)(2616005)(2906002)(4326008)(478600001)(83380400001)(186003)(16526019)(86362001)(6666004)(6486002)(52116002)(316002)(5660300002)(31686004)(36756003)(66946007)(31696002)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y3BjL3RLYUlLdVFkMXNJcDVJdDRRdHpvZ1RFTTFoayt2ZVpTMXhSL0JpV1Fp?=
 =?utf-8?B?Z1BkTWpLTkhaRW9MeEprZElVYzR5Y3JqdExLVHViTS9NUFBNMHZRbTcrakFz?=
 =?utf-8?B?eHhPT2RFdXhrcGswa2JMVkYvMWp6OXR6NjZ0NWlQeGNJWVkyZ3N4MVc0QmZ6?=
 =?utf-8?B?NVNwM3FhNHk3THU3THZRb1I5QzBaU3ZLbXpTVElhVE9ma1pZUEZIQ0s2cHZS?=
 =?utf-8?B?L1grQlNoYXBGL204ZkQwZHZBUlNmdVpHRmpJaUpGL0t0eTZwaktXQVB0SE85?=
 =?utf-8?B?TjZ6K3owRklVVUJOcCtiR0kvOUpUTWp0V3RhZk5Bc2VjTlk5ZGtxS01KSFJl?=
 =?utf-8?B?NU5uYjgvZ2g5dHBIaDNJQkFBam9pRTN1QWY1K0l4L3ArUWpQMUVpZXhrQ3JW?=
 =?utf-8?B?Z2o0cEprRE4zeDdWNHNkenkvK0YzRUhkSTQrMnpzVEt2QjlzalRJU1pkRkpy?=
 =?utf-8?B?dVY3NCt1VUVKVkMrM2Zuc1hTTFplcmwxZUwreGNmN0RSQWplTGpZOFlneVNN?=
 =?utf-8?B?VDU1ZHVSb2M4TjhPTm5UTkphd3IwQUJyRkQwWkVGVm5TZjdJQlpUbjV2dXpx?=
 =?utf-8?B?MVpCQXcvMkY1V2FrYkg5Y3lRTXZENmgyVWtjQVdnWmxGeU54dXNVMHAweUR6?=
 =?utf-8?B?VjZQdFlYdS9xVTRZMUZ0MW9JUmlBczEyMDhLQmVTTU5DcSsycXAxWkEvdzQw?=
 =?utf-8?B?RzVhemFrTTNZS3hxYm1yMTlWM1FyYzFMd0s5NzhXbWxRcEdaUUVOS0ZKNmhR?=
 =?utf-8?B?Qzl6eWtPWkhOd2ZGbzF2djZWU0svdG9XbDJvVjFISncydmx6c2ZpRXpwWXl2?=
 =?utf-8?B?MVRlQXBhMFl6T2ZCUlFxa0F2NFUyandpRnNETTJlMEEyN1FpU3hSZm5scXp6?=
 =?utf-8?B?dE1iUnp2QjR2Y1ZJNjlNSzh5RXNOT3F0R0JPdlhYV3J5bnFQZUQzUTBtQnB3?=
 =?utf-8?B?a09SaDBGYXgzYzN6c1IyN2xKTWwrOEJpdTNqbXZneHZ5Zm1Zd2VjMkM0Kzg1?=
 =?utf-8?B?WDgzSG9kMEo3SzlDVWtFZ3Jtbm5pekJmbk5nTDJQTkFaaXQxWU90MUZwaG1K?=
 =?utf-8?B?ZzFVT1pKYURUZXV5UTdiRmdmaWFaa05DTVh5TXcvdWlKekEyTHVVUVpIMGha?=
 =?utf-8?B?U1FLQXplRjJXcG5HdkkxYnBKd0wzOWZUK2F3cWJpL0pOL1dMTFFmMEFBZGRt?=
 =?utf-8?B?ZXp1NzNBVUFyOEdvZHFjWjRnQWZTeG0wNnNXekNaU1JxMVFoYnJFa0dPbk9v?=
 =?utf-8?B?Q2NDYkVtamJJai9sSnZJV0ZzK1BFOGtMdHkweFhsVGxaeC96YUxGWEdiMUZl?=
 =?utf-8?B?M2Q4NkJRczJNdnJWT0xGQ0YxQWxLMHZmdlFQQkRTZzJhRmZMa2Nrb3JCekZI?=
 =?utf-8?B?MlRXUjUybzk0MjdJQXI4a08zbDV4T1hqNlgzS0VMZHBDZDA5M0g3SGxDRGd1?=
 =?utf-8?B?ejNpK0xzOUlXN1U2eHJKS3BjbG1WdGJMZFJWZHpmZERjb0RoU3pGaGFoaWdB?=
 =?utf-8?B?TTIyRWxwWGRwTXR3ZzRXVlR6c0dvbithU3dHOGFndGFkMnlCemI1V1BialVV?=
 =?utf-8?B?OFFWQ0dvVlhtRGhYTisyM1NNNndpMUw4YlpFK0ZzajRuME52SHJWaXIzRmsy?=
 =?utf-8?B?TWNEaFlweElhc2FCQzQ5WmcwK2ttZGpYNE9pZXQ1UnIreGZjVmVRU0x3ZGh6?=
 =?utf-8?B?N1JMU21ZRUQ3QWlqUnNoS1FNZjFuZGlOdSs2QldwNVRIVWFzWTVYVW5vZjM4?=
 =?utf-8?B?enZOZ3N4NDI1S21hcUdEeGFjZG0xVGJvZW11M0FNU21SNUFnTlRwTTJudFFt?=
 =?utf-8?B?UVFPM2xPd1Q4LzluTWhNd2NvMGFrak0zOThrVHdNVUg1QUhCTWVQYUM5NHFi?=
 =?utf-8?Q?KoeJPS1bhcnur?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd487a29-17e4-484b-9c38-08d8e9556913
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 15:00:32.5985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLrMh4wR33daosGzSl6DwF3zlrSeUcGnVg3hGuZrdOJZbVxzEpk2AwvkT3yCMiS/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3887
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTcuMDMuMjEgdW0gMTU6NDggc2NocmllYiBDaGVuIExpOgo+Cj4ga3ZtYWxsb2NfYXJyYXkg
KyBfX0dGUF9aRVJPIGlzIHRoZSBzYW1lIHdpdGgga3ZjYWxsb2MuCj4KPiBBcyBmb3IgcC0+Y2h1
bmtzLCBpdCB3aWxsIGJlIHVzZWQgaW46Cj4gYGBgCj4gaWYgKGliX2NodW5rLT5rZGF0YSkKPiAJ
CW1lbWNweShwYXJzZXItPmliLnB0ciwgaWJfY2h1bmstPmtkYXRhLCBpYl9jaHVuay0+bGVuZ3Ro
X2R3ICogNCk7Cj4gYGBgCj4KPiBJZiBjaHVua3MgZG9lc24ndCB6ZXJvIG91dCB3aXRoIF9fR0ZQ
X1pFUk8sIGl0IG1heSBwb2ludCB0byBzb21ld2hlcmUgZWxzZSwgZS5nLiwKPiBgYGAKPiBVbmFi
bGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAw
MDAwMDAwMDAxMDAwMAo+IC4uLgo+IHBjIGlzIGF0IG1lbWNweSsweDg0LzB4MjUwCj4gcmEgaXMg
YXQgcmFkZW9uX2NzX2lvY3RsKzB4MzY4LzB4YjkwIFtyYWRlb25dCj4gYGBgCj4KPiBhZnRlciBh
bGxvY2F0aW5nIGNodW5rcyB3aXRoIF9fR0ZQX0tFUk5FTC9rdmNhbGxvYywgdGhpcyBidWcgaXMg
Zml4ZWQuCj4gRml4ZXM6IDNmY2I0ZjAxZGVlZCAoImRybS9yYWRlb246IFVzZSBrdm1hbGxvYyBm
b3IgQ1MgY2h1bmtzIikKPiBTaWduZWQtb2ZmLWJ5OiBDaGVuIExpIDxjaGVubGlAdW5pb250ZWNo
LmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cgo+IC0tLQo+Cj4gY2hhbmdlbG9nOgo+ICAgIHYxLT52MjogYWRkIEZpeGVzOiB0YWcK
Pgo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYyB8IDYgKysrLS0tCj4gICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9jcy5jCj4gaW5kZXggZmI3MzZlZjlmOWFhLi4wNTk0MzE2ODljMmQg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMKPiBAQCAtOTMsOCArOTMsOCBAQCBz
dGF0aWMgaW50IHJhZGVvbl9jc19wYXJzZXJfcmVsb2NzKHN0cnVjdCByYWRlb25fY3NfcGFyc2Vy
ICpwKQo+ICAgCXAtPmRtYV9yZWxvY19pZHggPSAwOwo+ICAgCS8qIEZJWE1FOiB3ZSBhc3N1bWUg
dGhhdCBlYWNoIHJlbG9jcyB1c2UgNCBkd29yZHMgKi8KPiAgIAlwLT5ucmVsb2NzID0gY2h1bmst
Pmxlbmd0aF9kdyAvIDQ7Cj4gLQlwLT5yZWxvY3MgPSBrdm1hbGxvY19hcnJheShwLT5ucmVsb2Nz
LCBzaXplb2Yoc3RydWN0IHJhZGVvbl9ib19saXN0KSwKPiAtCQkJR0ZQX0tFUk5FTCB8IF9fR0ZQ
X1pFUk8pOwo+ICsJcC0+cmVsb2NzID0ga3ZjYWxsb2MocC0+bnJlbG9jcywgc2l6ZW9mKHN0cnVj
dCByYWRlb25fYm9fbGlzdCksCj4gKwkJCUdGUF9LRVJORUwpOwo+ICAgCWlmIChwLT5yZWxvY3Mg
PT0gTlVMTCkgewo+ICAgCQlyZXR1cm4gLUVOT01FTTsKPiAgIAl9Cj4gQEAgLTI5OSw3ICsyOTks
NyBAQCBpbnQgcmFkZW9uX2NzX3BhcnNlcl9pbml0KHN0cnVjdCByYWRlb25fY3NfcGFyc2VyICpw
LCB2b2lkICpkYXRhKQo+ICAgCX0KPiAgIAlwLT5jc19mbGFncyA9IDA7Cj4gICAJcC0+bmNodW5r
cyA9IGNzLT5udW1fY2h1bmtzOwo+IC0JcC0+Y2h1bmtzID0ga3ZtYWxsb2NfYXJyYXkocC0+bmNo
dW5rcywgc2l6ZW9mKHN0cnVjdCByYWRlb25fY3NfY2h1bmspLCBHRlBfS0VSTkVMKTsKPiArCXAt
PmNodW5rcyA9IGt2Y2FsbG9jKHAtPm5jaHVua3MsIHNpemVvZihzdHJ1Y3QgcmFkZW9uX2NzX2No
dW5rKSwgR0ZQX0tFUk5FTCk7Cj4gICAJaWYgKHAtPmNodW5rcyA9PSBOVUxMKSB7Cj4gICAJCXJl
dHVybiAtRU5PTUVNOwo+ICAgCX0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
