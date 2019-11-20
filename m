Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BEBC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 01:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122BF223D8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 01:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122BF223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C6536E3F0;
	Wed, 20 Nov 2019 01:57:36 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760075.outbound.protection.outlook.com [40.107.76.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 486D76E3F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 01:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZNMzNH7Ky2tQu7VmptxAEU5YytXgW2CexzhkCWUHpZRfTr3zqlSvQlNdE5U1oAQHlH27kkoGdfrfxGJ6XO4PYmiYL04VbNSz2M2uqmtqXaOh6JgSsex8i9kixi3Hvc2B15dbnD0t4xQAYJd+D1VtgaU/T8jJAbfxKTQcCKCpwb1X90RPcjvQ7hgooNYX8UBqCxxqHTHon3s1GOlBFBBq80M3o2QWtAigkjp2ZtuVFGSjnJczKm7/UggM9pt1Mw2MYMwWF77idj1+SHOzVgZBrpCujCZEdSqIrlkCVWk6sF3gIzF0+GcBS8LgyFouUh8YyIzYMboNGKpkw2DCZHF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTDJUSy2u1khNa6PoD/Shcs6a/vdEhCwN0Ypr5eyuU0=;
 b=I0l0xLPQJiLBM8Q9mIbAwAeC2iPI2NY0gb4ePfSENiht8E3kVvZZXRKsrl3wTqFx+aSaCgVL8Z4VbfUrlJQvkcXwZ6LyANt9Kz/X9+UNRdI5uj3Lt+yyP/ZKERqRy+rBzX35E2GVxIxruFDuEETqeb8FQJ6inagVIOnC5QuCcAapCxmDns5Lg7I9Gm1qDVD0wrH618yEbhnxa1tnuZA5x9xu+/SZBzd2Eqx6i2zE+TFbpFz7/y5tTCWJAUT+ll1utsvV1rNl44DLq5sqrTNCt6d9OLULnMwpC0L1MuVblMvW4P2JPECF2AX3N0gxMFS1BFsmyd8VCvasvsICCyYX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN8PR12MB3348.namprd12.prod.outlook.com (20.178.211.221) by
 BN8PR12MB3521.namprd12.prod.outlook.com (20.179.65.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Wed, 20 Nov 2019 01:57:32 +0000
Received: from BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::a158:1dcd:18f4:8b81]) by BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::a158:1dcd:18f4:8b81%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 01:57:32 +0000
Subject: Re: [PATCH 05/12] tests/amdgpu: expand write linear helper for
 security (v3)
To: Aaron Liu <aaron.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <1573788895-3936-5-git-send-email-aaron.liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <edfa0e38-ddb3-41cf-8efc-4d49606d397c@amd.com>
Date: Tue, 19 Nov 2019 20:57:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1573788895-3936-5-git-send-email-aaron.liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To BN8PR12MB3348.namprd12.prod.outlook.com
 (2603:10b6:408:47::29)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82e7b053-50f9-4a19-9826-08d76d5d015e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3521097E1CFDC6B8FB8B32CC994F0@BN8PR12MB3521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(14454004)(4326008)(52116002)(66946007)(2486003)(76176011)(66556008)(66476007)(23676004)(99286004)(25786009)(65956001)(66066001)(4001150100001)(8936002)(8676002)(65806001)(5660300002)(81156014)(81166006)(86362001)(478600001)(316002)(58126008)(6436002)(6486002)(31696002)(305945005)(47776003)(7736002)(50466002)(476003)(2616005)(44832011)(11346002)(446003)(6116002)(230700001)(186003)(26005)(486006)(36756003)(15650500001)(53546011)(6506007)(386003)(14444005)(3846002)(6512007)(2906002)(6246003)(229853002)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3521;
 H:BN8PR12MB3348.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAPuSyU+mukQePeNhx1nhDxMSndcvwV8a23kCb7vEPTjyvQiHViwLP9lUNrAd+PXk/zLYoXCCz37sKb6JRf1lpbW9KtuJh1yJuBBNRknf3bO2iJ+y8VH8mBh9AmVIurZkbcR+EKyCyevUR1vaX6o870Jsj/tLoCgb8kry8VL8xRRyUuaLWDCICOJ+Mg9CargtNeeFQ11OVUJkanyJS8ipgD+2MFNUrqQhkw8JEA5rtgayEJhOIcZ9+OlxLcI/pg8eD44jyOQTzCllLNk4zcfb12P4n2PP2On3IDhvePjPmCpVHlh5bfUOwLaiieyKydCbGufgcRL+AWn7jUm8lXKc/ZzZOeDa7nJxtNeezLL48abdduO2Vp0AIkBEaFUvb7/c0RaI0thJV43eNE5jLlPrXtbjmRJFbJj8skcOJSnCgI9OTrYT9AwT68882NhRX72
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e7b053-50f9-4a19-9826-08d76d5d015e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 01:57:32.0825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUIrUwdFoyd7V+Hd7qwFjT1I4f+LmEohqUK0Gz/BrLphgZHGfS1xDp+tfs+VPw0R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3521
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTDJUSy2u1khNa6PoD/Shcs6a/vdEhCwN0Ypr5eyuU0=;
 b=mehZonafeMXDC+nyqizTx84T5yWA27+TfPtX6U1H4mJvYeKSkSxzy8NCjbbvldFJQRcJXyTw/L4eQ1YZXuzl95Do1chuHMwvYnmGXLfH/q2OexSX2axk0Hw5b6hcYU+AQLEYh5t+NgGebTPL0GgpZUH40n2Cd0TvVIQr62sZ7FI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
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
Cc: Alexander.Deucher@amd.com, Marek.Olsak@amd.com, Ray.Huang@amd.com,
 Leo.Liu@amd.com, Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120015730.aZd_92zKhgDm7e68QotZJTHlKSwCMDo3kACcgKboY5E@z>

T24gMjAxOS0xMS0xNCAxMDozNCBwLm0uLCBBYXJvbiBMaXUgd3JvdGU6Cj4gRnJvbTogSHVhbmcg
UnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiAKPiBUaGlzIHBhdGNoIGV4cGFuZCB3cml0ZSBsaW5l
YXIgaGVscGVyIGZvciBzZWN1cml0eSB0byBzdWJtaXQgdGhlIGNvbW1hbmQKPiB3aXRoIHNlY3Vy
ZSBjb250ZXh0Lgo+IAo+IHYyOiByZWZpbmUgdGhlIGZ1bmN0aW9uIGltcGxlbWVudGF0aW9uLgo+
IHYzOiByZW1vdmUgYW1kZ3B1X2NzX2N0eF9jcmVhdGUzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEh1
YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQWFyb24gTGl1IDxh
YXJvbi5saXVAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgo+IC0tLQo+ICB0ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaCB8ICA0
ICsrKysKPiAgdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMgfCAxNSArKysrKysrKysrKysrLS0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+
IGRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaCBiL3Rlc3RzL2FtZGdwdS9h
bWRncHVfdGVzdC5oCj4gaW5kZXggYjdmOGRlMi4uNjdiZTQzNyAxMDA2NDQKPiAtLS0gYS90ZXN0
cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaAo+ICsrKyBiL3Rlc3RzL2FtZGdwdS9hbWRncHVfdGVzdC5o
Cj4gQEAgLTI2Miw2ICsyNjIsOSBAQCBDVV9CT09MIHN1aXRlX3NlY3VyaXR5X3Rlc3RzX2VuYWJs
ZSh2b2lkKTsKPiAgICovCj4gIGV4dGVybiBDVV9UZXN0SW5mbyBzZWN1cml0eV90ZXN0c1tdOwo+
ICAKPiArZXh0ZXJuIHZvaWQKPiArYW1kZ3B1X2NvbW1hbmRfc3VibWlzc2lvbl93cml0ZV9saW5l
YXJfaGVscGVyX3dpdGhfc2VjdXJlKHVuc2lnbmVkIGlwX3R5cGUsCj4gKwkJCQkJCQkgIGJvb2wg
c2VjdXJlKTsKPiAgCj4gIC8qKgo+ICAgKiBIZWxwZXIgZnVuY3Rpb25zCj4gQEAgLTQ1Miw0ICs0
NTUsNSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgYXNpY19pc19hcmN0dXJ1cyh1aW50MzJfdCBhc2lj
X2lkKQo+ICAJfQo+ICB9Cj4gIAo+ICsKPiAgI2VuZGlmICAvKiAjaWZkZWYgX0FNREdQVV9URVNU
X0hfICovCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jIGIvdGVzdHMv
YW1kZ3B1L2Jhc2ljX3Rlc3RzLmMKPiBpbmRleCBhNTdkY2JiLi4zMWM5YTU0IDEwMDY0NAo+IC0t
LSBhL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCj4gKysrIGIvdGVzdHMvYW1kZ3B1L2Jhc2lj
X3Rlc3RzLmMKPiBAQCAtNzEsNyArNzEsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdGVzdF9leGVj
X2NzX2hlbHBlcihhbWRncHVfY29udGV4dF9oYW5kbGUgY29udGV4dF9oYW5kbGUsCj4gIAkJCQkg
ICAgICAgaW50IHJlc19jbnQsIGFtZGdwdV9ib19oYW5kbGUgKnJlc291cmNlcywKPiAgCQkJCSAg
ICAgICBzdHJ1Y3QgYW1kZ3B1X2NzX2liX2luZm8gKmliX2luZm8sCj4gIAkJCQkgICAgICAgc3Ry
dWN0IGFtZGdwdV9jc19yZXF1ZXN0ICppYnNfcmVxdWVzdCk7Cj4gLSAKPiArCj4gIENVX1Rlc3RJ
bmZvIGJhc2ljX3Rlc3RzW10gPSB7Cj4gIAl7ICJRdWVyeSBJbmZvIFRlc3QiLCAgYW1kZ3B1X3F1
ZXJ5X2luZm9fdGVzdCB9LAo+ICAJeyAiVXNlcnB0ciBUZXN0IiwgIGFtZGdwdV91c2VycHRyX3Rl
c3QgfSwKPiBAQCAtMTM2MSw3ICsxMzYxLDggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Rlc3RfZXhl
Y19jc19oZWxwZXIoYW1kZ3B1X2NvbnRleHRfaGFuZGxlIGNvbnRleHRfaGFuZGxlLAo+ICAJQ1Vf
QVNTRVJUX0VRVUFMKHIsIDApOwo+ICB9Cj4gIAo+IC1zdGF0aWMgdm9pZCBhbWRncHVfY29tbWFu
ZF9zdWJtaXNzaW9uX3dyaXRlX2xpbmVhcl9oZWxwZXIodW5zaWduZWQgaXBfdHlwZSkKPiArdm9p
ZCBhbWRncHVfY29tbWFuZF9zdWJtaXNzaW9uX3dyaXRlX2xpbmVhcl9oZWxwZXJfd2l0aF9zZWN1
cmUodW5zaWduZWQgaXBfdHlwZSwKPiArCQkJCQkJCSAgICAgICBib29sIHNlY3VyZSkKPiAgewoK
VGhpcyBpcyBhbiBleGFtcGxlIG9mIGJhZCBuYW1pbmcgb2YgYSBmdW5jdGlvbi4gQW5kIGl0IGlz
IGFsc28gdmVyeSBsb25nLiBUb28gbG9uZy4KCldoeSBkb2VzIHRoZSBuYW1lIG5lZWQgdG8gZW5k
IHdpdGggIl9zZWN1cmUoIj8gRG9lcyBpdCBtZWFuIHRoYXQgdGhlIHdyaXRlIGlzIGFsd2F5cwpz
ZWN1cmU/IE5vISBObywgaXQgZG9lc24ndCEgSWYgdGhlIHBhcmFtZXRlciwgaW4gdGhpcyBjYXNl
IHRoZSBzZWN1cml0eSBzdGF0ZSwgaXMKcGFyYW1ldGVyaXplZCwgYXMgaXQgaXMgdmlhIGEgZnVu
Y3Rpb24gYXJndW1lbnQsIHRoZW4geW91IGRvbid0IG5lZWQgdG8gYWRkIHRoaXMKYWxzbyB0byB0
aGUgbmFtZSBvZiB0aGUgZnVuY3Rpb24sIGFzIHlvdSBkaWQuCgphbWRncHVfY29tbWFuZF9zdWJt
aXNzaW9uX3dyaXRlX2xpbmVhcl9oZWxwZXIodW5zaWduZWQgaXBfdHlwZSwgYm9vbCBzZWN1cmUp
CgppcyBmaW5lIGZvciBhIG5hbWUuIExlYXZlIGl0IGF0IHRoYXQuCgpSZWdhcmRzLApMdWJlbgoK
PiAgCWNvbnN0IGludCBzZG1hX3dyaXRlX2xlbmd0aCA9IDEyODsKPiAgCWNvbnN0IGludCBwbTRf
ZHcgPSAyNTY7Cj4gQEAgLTEzOTAsNyArMTM5MSwxMSBAQCBzdGF0aWMgdm9pZCBhbWRncHVfY29t
bWFuZF9zdWJtaXNzaW9uX3dyaXRlX2xpbmVhcl9oZWxwZXIodW5zaWduZWQgaXBfdHlwZSkKPiAg
CXIgPSBhbWRncHVfcXVlcnlfaHdfaXBfaW5mbyhkZXZpY2VfaGFuZGxlLCBpcF90eXBlLCAwLCAm
aHdfaXBfaW5mbyk7Cj4gIAlDVV9BU1NFUlRfRVFVQUwociwgMCk7Cj4gIAo+ICsJZm9yIChpID0g
MDsgc2VjdXJlICYmIChpIDwgMik7IGkrKykKPiArCQlndHRfZmxhZ3NbaV0gfD0gQU1ER1BVX0dF
TV9DUkVBVEVfRU5DUllQVEVEOwo+ICsKPiAgCXIgPSBhbWRncHVfY3NfY3R4X2NyZWF0ZShkZXZp
Y2VfaGFuZGxlLCAmY29udGV4dF9oYW5kbGUpOwo+ICsKPiAgCUNVX0FTU0VSVF9FUVVBTChyLCAw
KTsKPiAgCj4gIAkvKiBwcmVwYXJlIHJlc291cmNlICovCj4gQEAgLTE0NjksNiArMTQ3NCwxMiBA
QCBzdGF0aWMgdm9pZCBhbWRncHVfY29tbWFuZF9zdWJtaXNzaW9uX3dyaXRlX2xpbmVhcl9oZWxw
ZXIodW5zaWduZWQgaXBfdHlwZSkKPiAgCUNVX0FTU0VSVF9FUVVBTChyLCAwKTsKPiAgfQo+ICAK
PiArc3RhdGljIHZvaWQgYW1kZ3B1X2NvbW1hbmRfc3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVs
cGVyKHVuc2lnbmVkIGlwX3R5cGUpCj4gK3sKPiArCWFtZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25f
d3JpdGVfbGluZWFyX2hlbHBlcl93aXRoX3NlY3VyZShpcF90eXBlLAo+ICsJCQkJCQkJCSAgZmFs
c2UpOwo+ICt9Cj4gKwo+ICBzdGF0aWMgdm9pZCBhbWRncHVfY29tbWFuZF9zdWJtaXNzaW9uX3Nk
bWFfd3JpdGVfbGluZWFyKHZvaWQpCj4gIHsKPiAgCWFtZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25f
d3JpdGVfbGluZWFyX2hlbHBlcihBTURHUFVfSFdfSVBfRE1BKTsKPiAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
