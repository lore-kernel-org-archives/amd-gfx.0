Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B1AC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 19:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940802071E
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 19:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940802071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504E46E17C;
	Mon, 25 Nov 2019 19:38:33 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790084.outbound.protection.outlook.com [40.107.79.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B34C6E17C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 19:38:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbK2vX/iOEO++7SYrIrwBHtbNmKsP6ivdvpalniSDTf/2nSaYriW5QCGXbarv7WtTSd2GwEdrTlXzzlEHCUqDAldfmU7REafzA04o+hMBES6hUF8r2ns6p45l6YctHYPTiN6l9oJG9mDWnJZ2CuFZGV/Wki3u1un1qKOzGaJOpV1mvIm7Y2R705iD4TsGsivk8kIvbkk4LbqUaTidKdievo/ocC4pcRxAiMuy2eGStAsWnq35IvT/gnhQ7jf1aTV2BsTe7SnzdCxNJWVa44TruZMBfwuXz0Z3GfGuTYIwTsuQh+1CpHyK9zkBAdj4u4baQu+fY4WHgLan1ICQbEpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELsaedMlI4m1gJmq7jg6PRn9+gVGgIx6YpumAan5pDs=;
 b=UqX8yglOjWb5qpmTEbcRDSqe8JDd3mJux110rN6iPMGjOQD4TP1jge2t5ISC1coyaVr0L2RIoxKNPlTtWIhF9HwAApsm/fR8CKriN8ABbDCPIyEcomT5c/+5aOeI9FDsxn7rlwDdEw2wdwkV4qKccsW+7IESEnfllju5BteOIxICRJHEgbHREnci0rlOYpMwsu41WKdy7QEx8FWnw2B02mv92wOhyrScBV/fu6clgnYy/WhS1cLh4oNOpUSxQfe1PY/F5o8iD/5EtiWk8VNGZOUxXQk/1jBieIhf/JYpXWjdk4aWEDL1FTlbvnE2uk0ya79j+2S3Y8eZ80WS0I4WYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB2969.namprd12.prod.outlook.com (20.178.29.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Mon, 25 Nov 2019 19:38:30 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 19:38:30 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Optimize KFD page table reservation
To: amd-gfx@lists.freedesktop.org, Xinhui.Pan@amd.com
References: <20191125193526.19803-1-Felix.Kuehling@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <48d3a288-39cf-0d55-43dd-021173c3ceb1@amd.com>
Date: Mon, 25 Nov 2019 14:38:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191125193526.19803-1-Felix.Kuehling@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::48) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1be415c-fc01-450d-d2f8-08d771df0c9c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2969:|DM6PR12MB2969:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29695730BEA0DA9B1A3368D1924A0@DM6PR12MB2969.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(86362001)(58126008)(2616005)(81156014)(81166006)(66946007)(8936002)(386003)(66476007)(66066001)(5660300002)(2906002)(50466002)(2870700001)(65956001)(316002)(65806001)(3846002)(6116002)(47776003)(6436002)(11346002)(99286004)(14454004)(14444005)(36756003)(6486002)(446003)(229853002)(26005)(31696002)(52116002)(25786009)(478600001)(66556008)(6506007)(8676002)(4001150100001)(53546011)(6636002)(76176011)(31686004)(186003)(44832011)(6512007)(2486003)(23676004)(305945005)(7736002)(6246003)(36916002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2969;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQfT76RBLU/lYdNrKPP3Wk7MQ1/eHP5Kx/uPZvTHdY9pitnBz/ct/Y9ZlB3yJZ+SGp//w4lPF+fW42fgw1JELHF79czefL/sYNYHz+GMdQ1+BwzIu8fLTcLVgF8o/4LJxBr3kJwRM5wDVSTBUo8Qk4MSqYHPWVUAqI4E66fGmXAv55/y4ynD5zv/3Xy8fOmmc16LoaQoy0SgLZTHXAVFLYzkQrz2WGKapRMLrXn+xTvyFD+YWET5ciBaC0gc5JQYX4d5PS/gUNokyr5BMLJg/yyDqc4Ll8Z7aAIjucchNoFKU0nLxhlTqW5auLqweW3Bb/7x2YETPsvlhLtrQjcmm+IvFjOIFWBN+UMgBg0PNIvGmPxsOenlSLltH3jU92lps1ppQzNkSmcjrMz5WUHnB2h9TkZDzMsrLWTKfXhRHm/Fm3YuNH2eranlFLzuF5Sk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1be415c-fc01-450d-d2f8-08d771df0c9c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 19:38:30.1973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbmKNWeGyM6C+Vipaj8IWYTkuu0pXjIfFUEqV26GQTWy4VDFcYtxnCFJ/rMgaLbZeMTNyY6uuKfwDieGsbJYXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2969
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELsaedMlI4m1gJmq7jg6PRn9+gVGgIx6YpumAan5pDs=;
 b=aIKqCbW//fsna0p/p5kC4Y3HwcKR3/CG/P95uNRujk2ld00TNtjfzqvzN339eWXFTE+8wSShDO4yzlzOuXqN7VcP4aOz7JfMR/N2NldGYWM4kBWS5AkaCo6ateCBna3mJumBbFepbIZ2JGLVPcmIF8uYEb06/vQa8afjH3qDsKw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125193828.lgdb_vM48Vq7ONKGVdNqQ3Uzw624012S2dhdHWNDSXk@z>

SGkgWGluaHVpLAoKSSBzZW50IHRoaXMgcGF0Y2ggaW4gSnVseSBhbmQgdGhlbiBmb3Jnb3QgYWJv
dXQgaXQuIFBsZWFzZSByZXZpZXcgaXQuIApZb3UgY291bGQgdXNlIHRoaXMgYXMgdGhlIGJhc2lz
IGZvciB5b3VyIGhlYXAtc2l6ZSBpbXByb3ZlbWVudC4gSnVzdCAKbW92ZSB0aGUgRVNUSU1BVEVf
UFRfU0laRSBtYWNybyBpbnRvIGFuIGFwcHJvcHJpYXRlIGhlYWRlciBmaWxlIHNvIHlvdSAKY2Fu
IHVzZSBpdCBpbiB0aGUgS0ZEIGNvZGUuCgpSZWdhcmRzLAogwqAgRmVsaXgKCk9uIDIwMTktMTEt
MjUgMjozNSBwLm0uLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPiBCZSBsZXNzIHBlc3NpbWlzdGlj
IGFib3V0IGVzdGltYXRlZCBwYWdlIHRhYmxlIHVzZSBmb3IgS0ZELiBNb3N0Cj4gYWxsb2NhdGlv
bnMgdXNlIDJNQiBwYWdlcyBhbmQgdGhlcmVmb3JlIG5lZWQgbGVzcyBWUkFNIGZvciBwYWdlCj4g
dGFibGVzLiBUaGlzIGFsbG93cyBtb3JlIFZSQU0gdG8gYmUgdXNlZCBmb3IgYXBwbGljYXRpb25z
IGVzcGVjaWFsbHkKPiBvbiBsYXJnZSBzeXN0ZW1zIHdpdGggbWFueSBHUFVzIGFuZCBodW5kcmVk
cyBvZiBHQiBvZiBzeXN0ZW0gbWVtb3J5Lgo+Cj4gRXhhbXBsZTogOCBHUFVzIHdpdGggMzJHQiBW
UkFNIGVhY2ggKyAyNTZHQiBzeXN0ZW0gbWVtb3J5ID0gNTEyR0IKPiBPbGQgcGFnZSB0YWJsZSBy
ZXNlcnZhdGlvbiBwZXIgR1BVOiAgMUdCCj4gTmV3IHBhZ2UgdGFibGUgcmVzZXJ2YXRpb24gcGVy
IEdQVTogMzJNQgo+Cj4gU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhs
aW5nQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
YW1ka2ZkX2dwdXZtLmMgfCAxNSArKysrKysrKysrKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gaW5kZXggYTFlZDhhOGUzNzUyLi5l
NDNhOTU1MTRiNDEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZF9ncHV2bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZF9ncHV2bS5jCj4gQEAgLTEwNSwxMSArMTA1LDI0IEBAIHZvaWQgYW1kZ3B1X2Ft
ZGtmZF9ncHV2bV9pbml0X21lbV9saW1pdHModm9pZCkKPiAgIAkJKGtmZF9tZW1fbGltaXQubWF4
X3R0bV9tZW1fbGltaXQgPj4gMjApKTsKPiAgIH0KPiAgIAo+ICsvKiBFc3RpbWF0ZSBwYWdlIHRh
YmxlIHNpemUgbmVlZGVkIHRvIHJlcHJlc2VudCBhIGdpdmVuIG1lbW9yeSBzaXplCj4gKyAqCj4g
KyAqIFdpdGggNEtCIHBhZ2VzLCB3ZSBuZWVkIG9uZSA4IGJ5dGUgUFRFIGZvciBlYWNoIDRLQiBv
ZiBtZW1vcnkKPiArICogKGZhY3RvciA1MTIsID4+IDkpLiBXaXRoIDJNQiBwYWdlcywgd2UgbmVl
ZCBvbmUgOCBieXRlIFBURSBmb3IgMk1CCj4gKyAqIG9mIG1lbW9yeSAoZmFjdG9yIDI1NkssID4+
IDE4KS4gUk9DbSB1c2VyIG1vZGUgdHJpZXMgdG8gb3B0aW1pemUKPiArICogZm9yIDJNQiBwYWdl
cyBmb3IgVExCIGVmZmljaWVuY3kuIEhvd2V2ZXIsIHNtYWxsIGFsbG9jYXRpb25zIGFuZAo+ICsg
KiBmcmFnbWVudGVkIHN5c3RlbSBtZW1vcnkgc3RpbGwgbmVlZCBzb21lIDRLQiBwYWdlcy4gV2Ug
Y2hvb3NlIGEKPiArICogY29tcHJvbWlzZSB0aGF0IHNob3VsZCB3b3JrIGluIG1vc3QgY2FzZXMg
d2l0aG91dCByZXNlcnZpbmcgdG9vCj4gKyAqIG11Y2ggbWVtb3J5IGZvciBwYWdlIHRhYmxlcyB1
bm5lY2Vzc2FyaWx5IChmYWN0b3IgMTZLLCA+PiAxNCkuCj4gKyAqLwo+ICsjZGVmaW5lIEVTVElN
QVRFX1BUX1NJWkUobWVtX3NpemUpICgobWVtX3NpemUpID4+IDE0KQo+ICsKPiAgIHN0YXRpYyBp
bnQgYW1kZ3B1X2FtZGtmZF9yZXNlcnZlX21lbV9saW1pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKPiAgIAkJdWludDY0X3Qgc2l6ZSwgdTMyIGRvbWFpbiwgYm9vbCBzZykKPiAgIHsKPiAr
CXVpbnQ2NF90IHJlc2VydmVkX2Zvcl9wdCA9Cj4gKwkJRVNUSU1BVEVfUFRfU0laRShhbWRncHVf
YW1ka2ZkX3RvdGFsX21lbV9zaXplKTsKPiAgIAlzaXplX3QgYWNjX3NpemUsIHN5c3RlbV9tZW1f
bmVlZGVkLCB0dG1fbWVtX25lZWRlZCwgdnJhbV9uZWVkZWQ7Cj4gLQl1aW50NjRfdCByZXNlcnZl
ZF9mb3JfcHQgPSBhbWRncHVfYW1ka2ZkX3RvdGFsX21lbV9zaXplID4+IDk7Cj4gICAJaW50IHJl
dCA9IDA7Cj4gICAKPiAgIAlhY2Nfc2l6ZSA9IHR0bV9ib19kbWFfYWNjX3NpemUoJmFkZXYtPm1t
YW4uYmRldiwgc2l6ZSwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
