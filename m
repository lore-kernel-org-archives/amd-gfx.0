Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EB7C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 11:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5482067D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 11:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5482067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5360B6E488;
	Mon, 18 Nov 2019 11:32:22 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750055.outbound.protection.outlook.com [40.107.75.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F37416E488
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 11:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5CqhflAbPuI0k5SAnikksWLADJVxe3YnYAeMLMsnbMQ6TAyKZyhC2eEqGrN0WaePrgbqN+YfVUxpMUbOEkoKL6VHDiiKxpzEicXLQTi8UH86OB3mgeoqDNHVZUF5GgGFf1Sk6LKyRNVzUO/tieR5uWBggB/NwPk2rSrrNkGNY5j6AeNX/ZdkdJKir6HVTcgKAWSnuWHAjV6dh2WfCspghvecpPHiTwSt/D8+mB1IbFPb6x1s7+W6ICRYf9a7rAPqWHcINwNUT1SPhuFPwB5uPbooky77KK5O4uGPh+8HqkR4/uDOYTKgd1TEmymItUGx0tJXl0m8pBdXnCKAEIJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYWEkMVsLTsikbVeSfQ/tas1OZCuSDDr+v1yHtPr/0Y=;
 b=QGj5ZDsH183mRRWuCvltZChBPbExOXXONqGRJMpYEDP5Z6vFjYAJ6a1BLhrnLrZXVXW04aEMV4R5OhTR3SZuIJgcGNWbDlE/+DGC7QwsiSzB2bBFtKe5kOZ3gFI6htBqWeOYROPntsplixNWe6+fpq9xtgaWdoFg5tVgaYiW0rDdnhknQwtiJ0IukHMctSB/imMPODDY4JViSgiJJtVn/cwrNPFC4PbF4R6qDaE10lakw2zZhtj07QX9SwCXuEjgZc4xojIw/gBLaBJzLhFPRfoYW0YfMtv9AOjflScJKFfrFFSliIeyVT6OVvV5gK1eTAX0huYdlFAgS1gzq9iIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1148.namprd12.prod.outlook.com (10.168.237.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Mon, 18 Nov 2019 11:32:19 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 11:32:19 +0000
Subject: Re: [PATCH] drm/amdgpu: put cancel dealyed work at first
To: Yintian Tao <yttao@amd.com>
References: <20191118082149.16712-1-yttao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <03d55ea8-8825-c65a-7193-9a0f11776595@amd.com>
Date: Mon, 18 Nov 2019 12:32:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191118082149.16712-1-yttao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BEXP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::22)
 To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db3ae15f-cc5b-438e-8854-08d76c1af88e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1148B2F1AFCA2BA98FFCB9B1834D0@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(50466002)(36756003)(6862004)(4326008)(5660300002)(6636002)(81166006)(81156014)(86362001)(65956001)(6512007)(316002)(99286004)(37006003)(58126008)(31696002)(229853002)(8676002)(230700001)(386003)(14444005)(66946007)(6506007)(478600001)(2616005)(305945005)(47776003)(14454004)(6486002)(8936002)(6436002)(25786009)(66476007)(23676004)(66556008)(2486003)(476003)(2906002)(46003)(486006)(6246003)(65806001)(11346002)(7736002)(446003)(186003)(52116002)(76176011)(6116002)(31686004)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1148;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQLrRX7MTE4LnHo1B8BOhecGjXhEnp+iQdQqlr9CNqkEmfp76Wu8bTQhr4b+Q4tmu+JRPgL00Gq2+SJ+E4SiohWBqykr/cLLBRpin58tRFQh5oHmkN/ScTOS8BXwcLYZSMMoNrsRiIX0uNHWsHY4dx7Yl6KtcVxfYuSQaHtMla+Pkylc3B6RElak9bijvvyJ3A+rYFWASczEEYp81HYNuhVcyATlDHPjdE0wHumEvp6PQ2dbXL9wnRmksB+tl9DISDgR1ekYlRkuGOlj2rhc82KGDo6e7DvrzeSFCZpokR7UfUZY1PNeIhGlNvNPgWm7LLccKlm06cYzJqALtAmmkQrA8V4f3SdJoq+dp3b56zetDR+IorFur9z5NKaeDAHjfbe0Ja8HLWcGj1xtk1MYAeYDY9/0Pos/unfiEdsJXWjBIAYjCzj95yO+53tQ3Iuw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3ae15f-cc5b-438e-8854-08d76c1af88e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 11:32:19.4153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lt+sv0KdgvwdLTVim6ikQKATJpiDYYsJUMqwn2vwPlFVeh77Y4qTSjMZ1XbTXr3H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYWEkMVsLTsikbVeSfQ/tas1OZCuSDDr+v1yHtPr/0Y=;
 b=TLDgUejPscmSzIiutPgCFXyEjt7GMtbEvcZ+8XrdFcGTP6Btn1Hzotd1KdpYoj4JXK6Z956tPehRtBYXJC53TRTk7LqIgIbdIJdn9Ukgi2RM+PiAshYt8R91ZcVpwqKe2k55bRPDkSjtyayyXYlziOKwDxoF9tAFp7PLuqquoOE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118113214.N9NHtFXK4pXLZ9UMZajxHb01JL8HRi_RG68md6YgZDc@z>

R29vZCBjYXRjaCwgYnV0IEkgd291bGQgc3RpbGwgcHJlZmVyIHRvIHVzZSBmbHVzaF9kZWxheWVk
X3dvcmsoKSBpbnN0ZWFkIApvZiBjYW5jZWxpbmcgaXQuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgpB
bSAxOC4xMS4xOSB1bSAwOToyMSBzY2hyaWViIFlpbnRpYW4gVGFvOgo+IFRoZXJlIGlzIG9uZSBy
ZWdyZXNzaW9uIGZyb20gMDQyZjNkN2I3NDVjZDc2YWEKPiBhbmQgb25lIGltcHJvdmVtZW50IGhl
cmUuCj4gLXJlZ3Jlc3Npb246Cj4gcHV0IGZsdXNoX2RlbGF5ZWRfd29yayBhZnRlciBhZGV2LT5z
aHV0ZG93biA9IHRydWUKPiB3aGljaCB3aWxsIG1ha2UgYW1kZ3B1X2loX3Byb2Nlc3Mgbm90IHJl
c3BvbnNlIHRoZSBpcnEKPiBBdCBsYXN0LCBhbGwgaWIgcmluZyB0ZXN0cyB3aWxsIGJlIGZhaWxl
ZCBqdXN0IGxpa2UgYmVsb3cKPgo+IFtkcm1dIGFtZGdwdTogZmluaXNoaW5nIGRldmljZS4KPiBb
ZHJtXSBGZW5jZSBmYWxsYmFjayB0aW1lciBleHBpcmVkIG9uIHJpbmcgZ2Z4Cj4gW2RybV0gRmVu
Y2UgZmFsbGJhY2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4wLjAKPiBbZHJtXSBGZW5j
ZSBmYWxsYmFjayB0aW1lciBleHBpcmVkIG9uIHJpbmcgY29tcF8xLjEuMAo+IFtkcm1dIEZlbmNl
IGZhbGxiYWNrIHRpbWVyIGV4cGlyZWQgb24gcmluZyBjb21wXzEuMi4wCj4gW2RybV0gRmVuY2Ug
ZmFsbGJhY2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4zLjAKPiBbZHJtXSBGZW5jZSBm
YWxsYmFjayB0aW1lciBleHBpcmVkIG9uIHJpbmcgY29tcF8xLjAuMQo+IGFtZGdwdSAwMDAwOjAw
OjA3LjA6IFtkcm06YW1kZ3B1X2liX3JpbmdfdGVzdHMgW2FtZGdwdV1dICpFUlJPUiogSUIgdGVz
dCBmYWlsZWQgb24gY29tcF8xLjEuMSAoLTExMCkuCj4gYW1kZ3B1IDAwMDA6MDA6MDcuMDogW2Ry
bTphbWRncHVfaWJfcmluZ190ZXN0cyBbYW1kZ3B1XV0gKkVSUk9SKiBJQiB0ZXN0IGZhaWxlZCBv
biBjb21wXzEuMi4xICgtMTEwKS4KPiBhbWRncHUgMDAwMDowMDowNy4wOiBbZHJtOmFtZGdwdV9p
Yl9yaW5nX3Rlc3RzIFthbWRncHVdXSAqRVJST1IqIElCIHRlc3QgZmFpbGVkIG9uIGNvbXBfMS4z
LjEgKC0xMTApLgo+IGFtZGdwdSAwMDAwOjAwOjA3LjA6IFtkcm06YW1kZ3B1X2liX3JpbmdfdGVz
dHMgW2FtZGdwdV1dICpFUlJPUiogSUIgdGVzdCBmYWlsZWQgb24gc2RtYTAgKC0xMTApLgo+IGFt
ZGdwdSAwMDAwOjAwOjA3LjA6IFtkcm06YW1kZ3B1X2liX3JpbmdfdGVzdHMgW2FtZGdwdV1dICpF
UlJPUiogSUIgdGVzdCBmYWlsZWQgb24gc2RtYTEgKC0xMTApLgo+IGFtZGdwdSAwMDAwOjAwOjA3
LjA6IFtkcm06YW1kZ3B1X2liX3JpbmdfdGVzdHMgW2FtZGdwdV1dICpFUlJPUiogSUIgdGVzdCBm
YWlsZWQgb24gdXZkX2VuY18wLjAgKC0xMTApLgo+IGFtZGdwdSAwMDAwOjAwOjA3LjA6IFtkcm06
YW1kZ3B1X2liX3JpbmdfdGVzdHMgW2FtZGdwdV1dICpFUlJPUiogSUIgdGVzdCBmYWlsZWQgb24g
dmNlMCAoLTExMCkuCj4gW2RybTphbWRncHVfZGV2aWNlX2RlbGF5ZWRfaW5pdF93b3JrX2hhbmRs
ZXIgW2FtZGdwdV1dICpFUlJPUiogaWIgcmluZyB0ZXN0IGZhaWxlZCAoLTExMCkuCj4KPiAtaW1w
cm92ZW1lbnQ6Cj4gSW4gZmFjdCwgdGhlcmUgaXMgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jIGlu
IHRoaXMgZnVjbnRpb24KPiBTbyB0aGVyZSBpcyBubyBuZWVkIHRvIGludm9rZSBmbHVzaF9kZWxh
eWVkX3dvcmsgYmVmb3JlCj4gY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jLiBKdXN0IHB1dCBjYW5j
ZWwgYXQgZmlyc3QKPgo+IFNpZ25lZC1vZmYtYnk6IFlpbnRpYW4gVGFvIDx5dHRhb0BhbWQuY29t
Pgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwg
NCArLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gaW5kZXgg
MTdiZTYzODlhZGY3Li5hMjQ1NGMzZWZjNjUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jCj4gQEAgLTMxMDksMTAgKzMxMDksOSBAQCB2b2lkIGFtZGdw
dV9kZXZpY2VfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAlpbnQgcjsKPiAg
IAo+ICAgCURSTV9JTkZPKCJhbWRncHU6IGZpbmlzaGluZyBkZXZpY2UuXG4iKTsKPiArCWNhbmNl
bF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+ZGVsYXllZF9pbml0X3dvcmspOwo+ICAgCWFkZXYt
PnNodXRkb3duID0gdHJ1ZTsKPiAgIAo+IC0JZmx1c2hfZGVsYXllZF93b3JrKCZhZGV2LT5kZWxh
eWVkX2luaXRfd29yayk7Cj4gLQo+ICAgCS8qIGRpc2FibGUgYWxsIGludGVycnVwdHMgKi8KPiAg
IAlhbWRncHVfaXJxX2Rpc2FibGVfYWxsKGFkZXYpOwo+ICAgCWlmIChhZGV2LT5tb2RlX2luZm8u
bW9kZV9jb25maWdfaW5pdGlhbGl6ZWQpewo+IEBAIC0zMTMwLDcgKzMxMjksNiBAQCB2b2lkIGFt
ZGdwdV9kZXZpY2VfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAkJYWRldi0+
ZmlybXdhcmUuZ3B1X2luZm9fZncgPSBOVUxMOwo+ICAgCX0KPiAgIAlhZGV2LT5hY2NlbF93b3Jr
aW5nID0gZmFsc2U7Cj4gLQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPmRlbGF5ZWRf
aW5pdF93b3JrKTsKPiAgIAkvKiBmcmVlIGkyYyBidXNlcyAqLwo+ICAgCWlmICghYW1kZ3B1X2Rl
dmljZV9oYXNfZGNfc3VwcG9ydChhZGV2KSkKPiAgIAkJYW1kZ3B1X2kyY19maW5pKGFkZXYpOwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
