Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B7FC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 17:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF01206CB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 17:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF01206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C8BB6E784;
	Wed, 20 Nov 2019 17:05:21 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820059.outbound.protection.outlook.com [40.107.82.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1923E6E89B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 17:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZW1EhgbZdGmwsDnij0H8hhizTjOXgqmeC7ugRhB8FFvFeidM+6qxTAGNCwiJfFYJvIPnyTZ2sow+phG9BGIOlcQjuOA0Ss5mh9XOdF4Qpz/fRrCFU2IiFtWtv+C0xxop4gUNL1XcAEb636AxSov+GmTt4opoB7k7XenfSzL1EMCSilVWv+2ScXuCS7CxEn/0OB/hDUmXBC56v4aeHFoQuZzUt/DtkPXNcHl4rhzh5faiR9HDsiBB827Ihw+rmGfzclpeSRbZUrFTDAkQPRPmJcEQqStcZC2gbyNYVMaKo6S8+RZ2ks8RHmez6/PHiqccQKqrAuhTOnbvGws3q7u9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEgZEsgL5rb1Bm2u9UXOmBzSHEarMF9KIk4xAQFfHsk=;
 b=nzKxX5aNVotba318hxXX8TlNfbiAw/qhTBQ5cF1Iyd3VmAOVzHYOEpnUr/RzGqUV8oyD3QysjufOgb4XFdp1Ps/K44rNWaRQV5pqjIAAvC/QPE4NQylns8qGN0oi9Hh0iqE+YSqwTD8FO+7dPeytGUhRDhy4iA/nM6WKa7R9o7JAR4ythlZqzzk49ZnjlCSCtSs9CQGFszoE7i2GeaGnY3h/zarTw/kaxTbeE27IBBcuh9G+GZpmP5mcBjr8aDvwoU0rz/+IgIRrnLv0c3J24Mg3bXGIoYs3T7R7NtsIfMSphhYf0Wh1b9uAMtvUs+NIY9F+6NQ6SRUxKqAJQF07Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0263.namprd12.prod.outlook.com (10.172.76.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Wed, 20 Nov 2019 17:05:18 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195%5]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 17:05:18 +0000
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
To: Luben Tuikov <luben.tuikov@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <6cba1e53-1c0d-d408-4d16-cae93ec9e62e@amd.com>
 <CAAxE2A6ZdjfV1vWh1KQmTR+gVFq0n098Gg8bWjprwdqvUQGQoQ@mail.gmail.com>
 <60f3793f-c568-798c-a516-870d2d20d8d8@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <3e6f8c10-6cfe-73c7-c656-1b2ad69f5eb2@amd.com>
Date: Wed, 20 Nov 2019 12:05:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <60f3793f-c568-798c-a516-870d2d20d8d8@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::33) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f17ae3b-0a32-4426-d91c-08d76ddbd1ad
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0263:
X-MS-Exchange-PUrlCount: 2
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02638EE48B678EB805A3DFD48C4F0@CY4PR1201MB0263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(199004)(189003)(81156014)(81166006)(8676002)(6486002)(2906002)(99286004)(4001150100001)(65956001)(486006)(25786009)(66556008)(47776003)(446003)(2616005)(66946007)(58126008)(11346002)(110136005)(66476007)(66066001)(316002)(476003)(8936002)(65806001)(305945005)(7736002)(3846002)(478600001)(14454004)(31696002)(5660300002)(186003)(6116002)(31686004)(229853002)(966005)(26005)(76176011)(36756003)(54906003)(52116002)(50466002)(6506007)(2486003)(53546011)(23676004)(386003)(4326008)(6246003)(6436002)(2870700001)(14444005)(6666004)(6306002)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0263;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jwwQJH5eKM6oA02tHQprOW7D9cq2UsApuctxjWXIvHtBtoaJgIHEKdLSLComq78UMmxprKgOOsfdiVe3ahq1sy2xWZkYbYNXQdYzy04sKy143fgzxydZYzUat8mQrbg8oPTb2x6jxVY9X2imYg1IHEJY4CKL4Kw4K+Aa8j31+GNJURRYF3gBOS38Lh6kNOoGAamCcF6Au0wEmM5ymjp1m54A5f8+4/XKgnebicQFMkYjA7z14EQjmX50EKu/myGJksej4Htuv5uhfi8C0ywi/DuNIZIs7KALd8cGj98mvqpERl9Kc6jnWXdiBzAQSUjinc7yz7TF0cbUpmfi18aMHjywmw2nOzsJKUUE/l7HZFzRllS5jP3po37rZ3n1n/EmUirxMQMcUzPqTLJywrXUtywlUuALhm25Ya/1zCKCKczbWrEyVDixLAB+J8hibGbByhKFnBll/IzuS/4HmXA9xj5eWpmANhNj0ed/p3ZdYA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f17ae3b-0a32-4426-d91c-08d76ddbd1ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 17:05:18.1330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYcTkE43dtcCybolV9eTSKTQN1KDDIFSrzQy8CWG14Fgzop1PUoLg/sNouJzNNMxH9/wrsbi8/Rq4ZsyYrRnzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0263
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEgZEsgL5rb1Bm2u9UXOmBzSHEarMF9KIk4xAQFfHsk=;
 b=podDzbK4jQeVKf5ApBlMSRrvaTU/tlIz39TfCKknP7MpsGsoqa+xwnZzM3We2X4yvA2EKtdhKVGY6da7JImI4W9JPBgA3I9oBxAyFFITOGlSRO1bGDQHHTIFMpJlogz/MYCZDL543qooNfVELV6wInhvhxVlA+QkZEJGzQVZbGk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak@amd.com>,
 Aaron Liu <aaron.liu@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Huang Rui <Ray.Huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120170515.rHowZz5VtvVerla-PQMt1Pd7RuSSgJKplu15odvDyQg@z>

T24gMjAxOS0xMS0yMCAxMTo0OSBhLm0uLCBMdWJlbiBUdWlrb3Ygd3JvdGU6Cj4gT24gMjAxOS0x
MS0xOSAyMTo0MSwgTWFyZWsgT2zFocOhayB3cm90ZToKPj4gT24gVHVlLCBOb3YgMTksIDIwMTkg
YXQgODo1MiBQTSBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tIDxtYWlsdG86bHVi
ZW4udHVpa292QGFtZC5jb20+PiB3cm90ZToKPj4KPj4gICAgIE9uIDIwMTktMTEtMTQgMTA6MzQg
cC5tLiwgQWFyb24gTGl1IHdyb3RlOgo+PiAgICAgPiBGcm9tOiBIdWFuZyBSdWkgPHJheS5odWFu
Z0BhbWQuY29tIDxtYWlsdG86cmF5Lmh1YW5nQGFtZC5jb20+Pgo+PiAgICAgPgo+PiAgICAgPiBU
byBhbGlnbiB0aGUga2VybmVsIHVhcGkgY2hhbmdlIGZyb20gQWxleDoKPj4gICAgID4KPj4gICAg
ID4gIkFkZCBhIGZsYWcgdG8gdGhlIEdFTV9DUkVBVEUgaW9jdGwgdG8gY3JlYXRlIGVuY3J5cHRl
ZCBidWZmZXJzLiBCdWZmZXJzIHdpdGgKPj4gICAgID4gdGhpcyBmbGFnIHNldCB3aWxsIGJlIGNy
ZWF0ZWQgd2l0aCB0aGUgVE1aIGJpdCBzZXQgaW4gdGhlIFBURXMgb3IgZW5naW5lcwo+PiAgICAg
PiBhY2Nlc3NpbmcgdGhlbS4gVGhpcyBpcyByZXF1aXJlZCBpbiBvcmRlciB0byBwcm9wZXJseSBh
Y2Nlc3MgdGhlIGRhdGEgZnJvbSB0aGUKPj4gICAgID4gZW5naW5lcy4iCj4+ICAgICA+Cj4+ICAg
ICA+IFdlIHdpbGwgdXNlIEdFTV9DUkVBVEVfRU5DUllQVEVEIGZsYWcgZm9yIHNlY3VyZSBidWZm
ZXIgYWxsb2NhdGlvbi4KPj4gICAgID4KPj4gICAgID4gU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVp
IDxyYXkuaHVhbmdAYW1kLmNvbSA8bWFpbHRvOnJheS5odWFuZ0BhbWQuY29tPj4KPj4gICAgID4g
UmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbSA8bWFp
bHRvOmFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Pgo+PiAgICAgPiAtLS0KPj4gICAgID7CoCBp
bmNsdWRlL2RybS9hbWRncHVfZHJtLmggfCA1ICsrKysrCj4+ICAgICA+wqAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQo+PiAgICAgPgo+PiAgICAgPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9kcm0vYW1kZ3B1X2RybS5oIGIvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oCj4+ICAgICA+IGlu
ZGV4IDVjMjhhYTcuLjFhOTVlMzcgMTAwNjQ0Cj4+ICAgICA+IC0tLSBhL2luY2x1ZGUvZHJtL2Ft
ZGdwdV9kcm0uaAo+PiAgICAgPiArKysgYi9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgKPj4gICAg
ID4gQEAgLTE0MSw2ICsxNDEsMTEgQEAgZXh0ZXJuICJDIiB7Cj4+ICAgICA+wqAgwqAqIHJlbGVh
c2luZyB0aGUgbWVtb3J5Cj4+ICAgICA+wqAgwqAqLwo+PiAgICAgPsKgICNkZWZpbmUgQU1ER1BV
X0dFTV9DUkVBVEVfVlJBTV9XSVBFX09OX1JFTEVBU0XCoCDCoCDCoCDCoCgxIDw8IDkpCj4+ICAg
ICA+ICsvKiBGbGFnIHRoYXQgQk8gd2lsbCBiZSBlbmNyeXB0ZWQgYW5kIHRoYXQgdGhlIFRNWiBi
aXQgc2hvdWxkIGJlCj4+ICAgICA+ICsgKiBzZXQgaW4gdGhlIFBURXMgd2hlbiBtYXBwaW5nIHRo
aXMgYnVmZmVyIHZpYSBHUFVWTSBvcgo+PiAgICAgPiArICogYWNjZXNzaW5nIGl0IHdpdGggdmFy
aW91cyBodyBibG9ja3MKPj4gICAgID4gKyAqLwo+PiAgICAgPiArI2RlZmluZSBBTURHUFVfR0VN
X0NSRUFURV9FTkNSWVBURUTCoCDCoCDCoCDCoCDCoCAoMSA8PCAxMCkKPj4KPj4gICAgIFN0eWxl
IQo+PiAgICAgVEFCIGNoYXI/IQo+Pgo+PiAgICAgWW91IGhhdmUgYSBUQUIgY2hhciBiZXR3ZWVu
ICIuLl9FTkNSWVBURUQiIGFuZCAiKDEgPDwgMTApIgo+PiAgICAgRG8gTk9UIGFkZC9pbnNlcnQg
VEFCIGNoYXJzIGluc3RlYWQgb2Ygc3BhY2UgdG8gYWxpZ24gY29sdW5tbnMhCj4+ICAgICBJZiB3
aGVuIHlvdSBwcmVzcyBUYWIga2V5IGEgdGFiIGlzIGluc2VydGVkLCBhcyBvcHBvc2VkIHRvIHRo
ZSBsaW5lCj4+ICAgICBpbmRlbnRlZCwgdGhlbiBETyBOT1QgdXNlIHRoaXMgZWRpdG9yLgo+PiAg
ICAgVGhlIFRhYiBrZXkgc2hvdWxkICJpbmRlbnQgYWNjb3JkaW5nIHRvIG1vZGUiIGJ5IGluc2Vy
dGluZyBUQUIgY2hhcnMuCj4+ICAgICBJZiB0aGUgbGluZSBpcyBhbHJlYWR5IGluZGVudGVkLCBh
cyB0aGlzIG9uZSBpcywgdGhlbiBpdCBzaG91bGQgZG8gbm90aGluZy4KPj4KPj4KPj4gSSBkaXNh
Z3JlZSB3aXRoIHRoaXMgMTAwJS4gVGFicyBvciBzcGFjZXMgZG9uJ3QgbWF0dGVyIGhlcmUgZnJv
bSBteSBwZXJzcGVjdGl2ZS4gSSBhbHNvIGRpc2FncmVlIHdpdGggeW91ciBsYW5ndWFnZS4gSXQn
cyBvdmVybHkgaW1wb2xpdGUuCj4gCj4gQnV0IGl0J3MgdGhlIGNvZGluZyBzdHlsZSBvZiBMaW51
eDogbGVhZGluZyB0YWJzIG9ubHkuIFRyeSBpdCB3aXRoIEVtYWNzIGFzIGRlc2NyaWJlZCBhbmQg
Z2l2ZW4gaW4KPiAKPiBsaW51eC9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0eWxlLnJz
dAo+IAo+IHN0YXJ0aW5nIGF0IGxpbmUgNTg5LiBBbmQgcHJlc3MgdGhlIFRhYiBrZXkgb24gYW4g
YWxyZWFkeSBpbmRlbnRlZCBsaW5lLS1ub3RoaW5nIHdpbGwgaGFwcGVuLiBMaW51eCBoYXMgdHJh
ZGl0aW9uYWxseQo+IHNodW5uZWQgZnJvbSBsb29zZSBUQUIgY2hhcnMgaW4gYWxyZWFkeSBpbmRl
bnRlZCBsaW5lczogbGVhZGluZyB0YWJzIG9ubHkgbW9kZS4gSW4gYSBwcm9wZXIgY29kZSBlZGl0
b3IKPiBwcmVzc2luZyB0aGUgVGFiIGtleSBvbmx5IGluZGVudHMgYWNjb3JkaW5nIHRvIGJ1ZmZl
ciBtb2RlLCBpdCBzaG91bGRuJ3QgaW5zZXJ0IGEgVGFiIGNoYXIgd2lsbHktbmlsbHkuCj4gUGVv
cGxlIG1heSBzZXQgdGhlaXIgdGFiIHN0b3BzIGRpZmZlcmVudGx5IGZvciBkaWZmZXJlbnQgdGFi
IHBvc2l0aW9ucyBhbmQgaW5zZXJ0aW5nIGEgdGFiIGNoYXIgbWF5IGRpc3BsYXkKPiBpbmNvcnJl
Y3RseS4gVGhlIG1vc3QgcG9ydGFibGUgd2F5IHRvIGFsaWduIGNvbHVtbnMgaW4gYW4gYWxyZWFk
eSBpbmRlbnRlZC1hY2NvcmRpbmctdG8tbW9kZSBsaW5lLCBpcwo+IHVzaW5nIHNwYWNlcy4gKE9m
IGNvdXJzZSB0aGlzIGRvZXNuJ3QgbWF0dGVyIHdoZW4gdXNpbmcgc3BhY2VzIHRvIGluZGVudCwg
YnV0IExpbnV4IHVzZXMgaGFyZCBUQUIgY2hhcnMKPiB0byBpbmRlbnQ6IGxpbnV4L0RvY3VtZW50
YXRpb24vcHJvY2Vzcy9jb2Rpbmctc3R5bGUucnN0LiAod2hpY2ggYWxzbyBzZWVtIHRvIGJlIHNl
dCB0byA4IGNoYXJzKSkKPiAKPiBJdCdzIGEgY29kZSByZXZpZXcsIHRoZXJlIGlzIG5vICJsYW5n
dWFnZSIuCgpNYXkgSSByZW1pbmQgeW91IHRoYXQgZnJlZWRlc2t0b3Aub3JnIGhvc3RlZCBwcm9q
ZWN0cyBmb2xsb3cgYSBjb2RlIG9mCmNvbmR1Y3QgWzFdLiBUaGlzIGFwcGxpZXMgd2hldGhlciB0
aGUgaW50ZXJhY3Rpb24gaXMgYSBjb2RlIHJldmlldyBvcgphbnkgb3RoZXIgaW50ZXJhY3Rpb24u
CgpJIGRvbid0IHRoaW5rIHlvdXIgbGFuZ3VhZ2Ugd2FzIG92ZXJseSBpbXBvbGl0ZSBidXQgaXQg
ZGlkIGNvbWUgYWNyb3NzIGEKYml0IHN0cm9uZy4gUGxlYXNlIGNvbnNpZGVyIGhvdyB5b3VyIHN0
YXRlbWVudHMgbWlnaHQgYmUgcGVyY2VpdmVkIGJ5CnRoZSBwZXJzb24gdGhleSdyZSBhZGRyZXNz
ZWQgdG8uCgpbMV0gaHR0cHM6Ly93d3cuZnJlZWRlc2t0b3Aub3JnL3dpa2kvQ29kZU9mQ29uZHVj
dC8KCkhhcnJ5Cgo+IAo+IFJlZ2FyZHMsCj4gTHViZW4KPiAKPj4KPj4gTWFyZWsKPiAKPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPiAKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
