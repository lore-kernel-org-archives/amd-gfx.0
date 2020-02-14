Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC76C3B19D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5173724650
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jr24h1Py"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5173724650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E99376F95E;
	Fri, 14 Feb 2020 15:14:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C606F95E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 15:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6+K6byQY5XHTuvXKO0SwN9tWpVrGQB6vGML+uaKK+ynhG3MraPt0kobHVKPUSprIUnVznO7zh+PtV9ZSIPYNdAudxbrH93WHTutos/x+9Ttc9bXlbzI8CCgSBaAStxalybCV58/iKM/tDZhOjjq9xfEgKglNb1qW3pJ4eBjaOcElI+SPWeDSB8+RSpk3BojRRll6xqjwqPpvxNR+sRD1/NX7srdTwgbWvzkgUMVoDj5j1hJvFtg9LZoyw5LX8Vc7LOH6hLVJAzNqsqtjNZiCiHnNKcwa20DpTLuZieVnJjaALrh/rE9Za9ZKS9wwvRtudkGddgiYlhDacoVfhanpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZFGdFK7ZdF3SZ4XBxY6gBqoEsWeJEa1QCVGpR80Mr4=;
 b=e3bRfEQNFIAuUNMg0jL+t364HbEvt41Qd8V2LIL4AlfBZHE59jea5teafWqXn5P52n/2RUiN0wfdlimIhPSxXANoyIoSXibvCvKAvHvK+KHWnwb0Z8p31B1P3atAAxNVNjtDPgk4BQNkso05e35v4t2SM92e2DDyNX4P3pRl4b87VM2wvp7qPpAu4EpW/Id8IzVoEOL1CZ1s5zP5QuerN2+oEdD0ziwIFVb514oWCB5OSfzNZKC4VO25cY/LJTt+8MJYvuYcsCl/YIvmXZDjobEgq2haFCQmgcuO/yV6MYIB3/so11jOV/2ipIT+iHv1lWRQPD+FbvzqPobFS3WLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZFGdFK7ZdF3SZ4XBxY6gBqoEsWeJEa1QCVGpR80Mr4=;
 b=jr24h1Pyckwxnbeq7ElG9k6lyZevvpGsWJkZp7FCHVzjCW1a1sjpN2zoakm+v8wqqDJ+daiepzrrMgKnJP2vL8haNclpQGQpXPhN9N3aFcwL55JaLSs0efb8KHLFeRBpVRPezjtUF1EIXKOiZUV6K7HN7PYqpgRuni6u0kx4Kk0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) by
 MN2PR12MB3566.namprd12.prod.outlook.com (20.178.243.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 15:13:59 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2707.031; Fri, 14 Feb 2020
 15:13:59 +0000
Subject: Re: [PATCH umr 1/2] rename mmBIF_BX_PF_MM_* for nbio 2.3
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
References: <20200214145034.16582-1-xiaojie.yuan@amd.com>
 <2a6a39da-f3bd-70f9-2b83-d95c03188345@amd.com>
 <1F96DDF2-209B-49C0-B332-B4DB044B38A8@amd.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <df99b441-3e27-19b5-3bd2-68481a807b1d@amd.com>
Date: Fri, 14 Feb 2020 10:13:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1F96DDF2-209B-49C0-B332-B4DB044B38A8@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQXPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::44) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
Received: from localhost.localdomain (64.231.93.139) by
 YQXPR01CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:41::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Fri, 14 Feb 2020 15:13:59 +0000
X-Originating-IP: [64.231.93.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e705124-208d-4e67-7b15-08d7b160849b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3566:|MN2PR12MB3566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB356691ABFA2DAD4934303305F7150@MN2PR12MB3566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(199004)(189003)(5660300002)(6862004)(31686004)(8676002)(316002)(36756003)(478600001)(66476007)(66556008)(6486002)(6506007)(956004)(66946007)(2906002)(52116002)(81156014)(31696002)(86362001)(37006003)(186003)(26005)(4326008)(2616005)(81166006)(6636002)(6512007)(8936002)(53546011)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3566;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlNfUdzS17FCFE5o1jMlToH0HUCikgx1o6T/LhAsNaRCbIYFnkgL3Xyfuvcvveq9M533SYs5OqJeSNkVsagx/pdWg5FBLDza1Nl9IQPjixKOcy0jmIS7ZbZmG2uhP3AjSh6ne/2vuwg8uutQ02KMcwEyQj2VWWRFEv/n4hzMzio9+Q/GbNZOpSpepMkGMmDTCHQJ8W/fYlOGalRRadSvOCHZKlKx1vIQc5wNNyK7rZ6DBrjPXqGrAiSVVjCYyA2m1PcYIQoLE+8wxBCsy/iNnL5vi7S4RumEt3BcWo4hp9wxCeVD/qAWUR8TUzSXtpJy3dJ7ng9BgOVYC0CEUnil5Y6cfGuWyW12287m4hR28PPrjhqSvaD67jlKquui7doP8a/8FfqKqtnP/d5vFwU7A+v4ob+0Q9FEU21VQAytm8E/peifVxSXy8U3cSwHf0Th
X-MS-Exchange-AntiSpam-MessageData: U5aRtVh4Qpfpak7vDc/G9Ew67ZyPBYy1poCs8yRB8g7zorEvaGfJ/TBwlDwex20F5Obd1y3eFa7q3BJVxtDKn29yskASe2uKPbICI+zu3JQBo5Zcl1/lGKngI3uOecogZzF1C5kx3uQPdwlB+AGc4g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e705124-208d-4e67-7b15-08d7b160849b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 15:13:59.7182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tY/S1xfpDO/mdXmiLx0bOl3GJIq9cDmwgXulLHTy3NhqkpcxCCrMG5FLSkvOVM7nwLEEGlnIgAUINTofirZUmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3566
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Qm90aCBmaXhlcyBwdXNoZWQgb3V0IHRvIG1hc3RlciAob24gZ2l0bGFiKQoKClRoYW5rcyBhZ2Fp
biEKCgpUb20KCk9uIDIwMjAtMDItMTQgMTA6MDYgYS5tLiwgWXVhbiwgWGlhb2ppZSB3cm90ZToK
PiBUaGFua3MgVG9tLiBJJ20ganVzdCBwdWJsaXNoaW5nIHRoaXMgcXVpY2sgZml4IHNvIHRoYXQg
SSBjYW4gY29udGludWUgbXkgZGVidWdnaW5nIHdpdGggdW1yLCBhbmQgeW91ciBzb2x1dGlvbiBz
b3VuZHMgbW9yZSByZWFzb25hYmxlIDsgKQo+Cj4gQlIsCj4gWGlhb2ppZQo+Cj4+IE9uIEZlYiAx
NCwgMjAyMCwgYXQgMTA6NTUgUE0sIFN0RGVuaXMsIFRvbSA8VG9tLlN0RGVuaXNAYW1kLmNvbT4g
d3JvdGU6Cj4+Cj4+IO+7v0hpLAo+Pgo+PiBUaGFua3MgZm9yIHRoZSBwYXRjaCBob3dldmVyIHNp
bmNlIHRoZSAqLmkgZmlsZXMgYXJlIG1hY2hpbmUgZ2VuZXJhdGUgSSdkIHJhdGhlciBsaWtlIHRv
IGF2b2lkIHBhdGNoZXMgbGlrZSB0aGlzIChzaW5jZSB0aGV5IHdpbGwgbmVlZCB0byBiZSBjb250
aW51YWxseSBhcHBsaWVkKS4KPj4KPj4gVGhlIGlkZWFsIHNvbHV0aW9uIGlzIHRvIGVpdGhlciBw
YXRjaCBzcmMvbGliL3JlYWRfdnJhbS5jIG9yIHRvIHBhdGNoIHRoZSBrZXJuZWwgaGVhZGVycy4g
IFRoZSBrZXJuZWwgaGVhZGVycyBhcmUgYWxzbyBsaWtld2lzZSBtYWNoaW5lIGdlbmVyYXRlZCBz
byBwYXRjaGluZyB1bXIgaXMgcHJvYmFibHkgdGhlIGJlc3QuCj4+Cj4+IEknbGwgZG8gdGhpcyBt
eXNlbGYuCj4+Cj4+IEkgd2lsbCBob3dldmVyIGFwcGx5IHBhdGNoICMyIG9mIHRoZSBzZXJpZXMu
Cj4+Cj4+IFRoYW5rcywKPj4KPj4gVG9tCj4+Cj4+Cj4+PiBPbiAyMDIwLTAyLTE0IDk6NTAgYS5t
LiwgWGlhb2ppZSBZdWFuIHdyb3RlOgo+Pj4gRml4ZXMgZm9sbG93aW5nIGVycm9yIHdoaWxlIGR1
bXBpbmcgZ2Z4IHJpbmc6Cj4+Pgo+Pj4gW0JVR106IHJlZyBbbW1NTV9JTkRFWF0gbm90IGZvdW5k
IG9uIGFzaWMgW25hdmkxMF0KPj4+IFtCVUddOiByZWcgW21tTU1fSU5ERVhfSEldIG5vdCBmb3Vu
ZCBvbiBhc2ljIFtuYXZpMTBdCj4+PiBbQlVHXTogcmVnIFttbU1NX0RBVEFdIG5vdCBmb3VuZCBv
biBhc2ljIFtuYXZpMTBdCj4+PiBDYW5ub3QgcmVhZCBmcm9tIHN5c3RlbSBtZW1vcnk6IE9wZXJh
dGlvbiBub3QgcGVybWl0dGVkCj4+PiBbRVJST1JdOiBBY2Nlc3Npbmcgc3lzdGVtIG1lbW9yeSBy
ZXR1cm5lZDogLTEKPj4+IENhbm5vdCByZWFkIGZyb20gc3lzdGVtIG1lbW9yeTogQmFkIGFkZHJl
c3MKPj4+IFtFUlJPUl06IEFjY2Vzc2luZyBzeXN0ZW0gbWVtb3J5IHJldHVybmVkOiAtMQo+Pj4K
Pj4+IFNpZ25lZC1vZmYtYnk6IFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55dWFuQGFtZC5jb20+Cj4+
PiAtLS0KPj4+ICAgc3JjL2xpYi9pcC9uYmlvMjMwX2JpdHMuaSB8IDYgKysrLS0tCj4+PiAgIHNy
Yy9saWIvaXAvbmJpbzIzMF9yZWdzLmkgfCA2ICsrKy0tLQo+Pj4gICAyIGZpbGVzIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvc3Jj
L2xpYi9pcC9uYmlvMjMwX2JpdHMuaSBiL3NyYy9saWIvaXAvbmJpbzIzMF9iaXRzLmkKPj4+IGlu
ZGV4IDUwNmNjYmEuLmZkNWJhZDggMTAwNjQ0Cj4+PiAtLS0gYS9zcmMvbGliL2lwL25iaW8yMzBf
Yml0cy5pCj4+PiArKysgYi9zcmMvbGliL2lwL25iaW8yMzBfYml0cy5pCj4+PiBAQCAtMSwxMSAr
MSwxMSBAQAo+Pj4gLXN0YXRpYyBzdHJ1Y3QgdW1yX2JpdGZpZWxkIG1tQklGX0JYX1BGX01NX0lO
REVYW10gPSB7Cj4+PiArc3RhdGljIHN0cnVjdCB1bXJfYml0ZmllbGQgbW1NTV9JTkRFWFtdID0g
ewo+Pj4gICAgICAgIHsgIk1NX09GRlNFVCIsIDAsIDMwLCAmdW1yX2JpdGZpZWxkX2RlZmF1bHQg
fSwKPj4+ICAgICAgICB7ICJNTV9BUEVSIiwgMzEsIDMxLCAmdW1yX2JpdGZpZWxkX2RlZmF1bHQg
fSwKPj4+ICAgfTsKPj4+IC1zdGF0aWMgc3RydWN0IHVtcl9iaXRmaWVsZCBtbUJJRl9CWF9QRl9N
TV9EQVRBW10gPSB7Cj4+PiArc3RhdGljIHN0cnVjdCB1bXJfYml0ZmllbGQgbW1NTV9EQVRBW10g
PSB7Cj4+PiAgICAgICAgeyAiTU1fREFUQSIsIDAsIDMxLCAmdW1yX2JpdGZpZWxkX2RlZmF1bHQg
fSwKPj4+ICAgfTsKPj4+IC1zdGF0aWMgc3RydWN0IHVtcl9iaXRmaWVsZCBtbUJJRl9CWF9QRl9N
TV9JTkRFWF9ISVtdID0gewo+Pj4gK3N0YXRpYyBzdHJ1Y3QgdW1yX2JpdGZpZWxkIG1tTU1fSU5E
RVhfSElbXSA9IHsKPj4+ICAgICAgICB7ICJNTV9PRkZTRVRfSEkiLCAwLCAzMSwgJnVtcl9iaXRm
aWVsZF9kZWZhdWx0IH0sCj4+PiAgIH07Cj4+PiAgIHN0YXRpYyBzdHJ1Y3QgdW1yX2JpdGZpZWxk
IG1tU1lTSFVCX0lOREVYX09WTFBbXSA9IHsKPj4+IGRpZmYgLS1naXQgYS9zcmMvbGliL2lwL25i
aW8yMzBfcmVncy5pIGIvc3JjL2xpYi9pcC9uYmlvMjMwX3JlZ3MuaQo+Pj4gaW5kZXggYWI1NzM4
NS4uMjdhNjQ0YiAxMDA2NDQKPj4+IC0tLSBhL3NyYy9saWIvaXAvbmJpbzIzMF9yZWdzLmkKPj4+
ICsrKyBiL3NyYy9saWIvaXAvbmJpbzIzMF9yZWdzLmkKPj4+IEBAIC0xLDYgKzEsNiBAQAo+Pj4g
LSAgICB7ICJtbUJJRl9CWF9QRl9NTV9JTkRFWCIsIFJFR19NTUlPLCAweDAwMDAsIDAsICZtbUJJ
Rl9CWF9QRl9NTV9JTkRFWFswXSwgc2l6ZW9mKG1tQklGX0JYX1BGX01NX0lOREVYKS9zaXplb2Yo
bW1CSUZfQlhfUEZfTU1fSU5ERVhbMF0pLCAwLCAwIH0sCj4+PiAtICAgIHsgIm1tQklGX0JYX1BG
X01NX0RBVEEiLCBSRUdfTU1JTywgMHgwMDAxLCAwLCAmbW1CSUZfQlhfUEZfTU1fREFUQVswXSwg
c2l6ZW9mKG1tQklGX0JYX1BGX01NX0RBVEEpL3NpemVvZihtbUJJRl9CWF9QRl9NTV9EQVRBWzBd
KSwgMCwgMCB9LAo+Pj4gLSAgICB7ICJtbUJJRl9CWF9QRl9NTV9JTkRFWF9ISSIsIFJFR19NTUlP
LCAweDAwMDYsIDAsICZtbUJJRl9CWF9QRl9NTV9JTkRFWF9ISVswXSwgc2l6ZW9mKG1tQklGX0JY
X1BGX01NX0lOREVYX0hJKS9zaXplb2YobW1CSUZfQlhfUEZfTU1fSU5ERVhfSElbMF0pLCAwLCAw
IH0sCj4+PiArICAgIHsgIm1tTU1fSU5ERVgiLCBSRUdfTU1JTywgMHgwMDAwLCAwLCAmbW1NTV9J
TkRFWFswXSwgc2l6ZW9mKG1tTU1fSU5ERVgpL3NpemVvZihtbU1NX0lOREVYWzBdKSwgMCwgMCB9
LAo+Pj4gKyAgICB7ICJtbU1NX0RBVEEiLCBSRUdfTU1JTywgMHgwMDAxLCAwLCAmbW1NTV9EQVRB
WzBdLCBzaXplb2YobW1NTV9EQVRBKS9zaXplb2YobW1NTV9EQVRBWzBdKSwgMCwgMCB9LAo+Pj4g
KyAgICB7ICJtbU1NX0lOREVYX0hJIiwgUkVHX01NSU8sIDB4MDAwNiwgMCwgJm1tTU1fSU5ERVhf
SElbMF0sIHNpemVvZihtbU1NX0lOREVYX0hJKS9zaXplb2YobW1NTV9JTkRFWF9ISVswXSksIDAs
IDAgfSwKPj4+ICAgICAgIHsgIm1tU1lTSFVCX0lOREVYX09WTFAiLCBSRUdfTU1JTywgMHgwMDA4
LCAwLCAmbW1TWVNIVUJfSU5ERVhfT1ZMUFswXSwgc2l6ZW9mKG1tU1lTSFVCX0lOREVYX09WTFAp
L3NpemVvZihtbVNZU0hVQl9JTkRFWF9PVkxQWzBdKSwgMCwgMCB9LAo+Pj4gICAgICAgeyAibW1T
WVNIVUJfREFUQV9PVkxQIiwgUkVHX01NSU8sIDB4MDAwOSwgMCwgJm1tU1lTSFVCX0RBVEFfT1ZM
UFswXSwgc2l6ZW9mKG1tU1lTSFVCX0RBVEFfT1ZMUCkvc2l6ZW9mKG1tU1lTSFVCX0RBVEFfT1ZM
UFswXSksIDAsIDAgfSwKPj4+ICAgICAgIHsgIm1tUENJRV9JTkRFWCIsIFJFR19NTUlPLCAweDAw
MGMsIDAsICZtbVBDSUVfSU5ERVhbMF0sIHNpemVvZihtbVBDSUVfSU5ERVgpL3NpemVvZihtbVBD
SUVfSU5ERVhbMF0pLCAwLCAwIH0sCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
