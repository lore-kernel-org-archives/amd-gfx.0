Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8C4C10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 13:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FFA20650
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 13:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FP8eUSth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FFA20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338716EAC2;
	Thu, 12 Mar 2020 13:42:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07266EAC2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 13:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KL4wuRqUCh8ocaaYpWOZLQgdY9Fh6B/S+o03oM3kSqXQR4VM3hAd1N8pM1PBFNo7HsMjebS19onyyjVjOMQsqE2bmjhdRIX4UBFwvj+8mlToUIGzy8d+1eAFlPAbXEi69u6cSkJjRkwaIINDZF/c+iRv3gxNiyugmkSKx/vo33XM3XmZr9wFNg9yiOQ/UNNBiDFbfBL/MeuRd1i4Y1peC29Rd4UlhRiddPgB2Okf02ICfNqPsxzgbmz8d1va4pI2+4IJHsqqQqF+UUDyaK+9J6munN51BI3iOtv2/UH6Z3OJhaQOgjpNsIMCXwNbRr9fX7Vo7sniHU8rV2w7LkUTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AouT7uUlxr+Mh8NWQ09M5uPAzgvCyc2PEEPQpHWDYig=;
 b=LZVKQx8eWh+wvf3r80TAQgEffHGnGnyHITp9+hhyLRzafcs/s/UOdMIo3jTQ39M2LYN1F+AA2jah7HhDffhyn1dMEmmB0/CV7uVm3YxQcK4fMFzmqvV3I00v3prRchiYq3rd83HNlnQwEGYzNJhWWqxXkzsf9reG3dg9RYU4JaLv2FOaSbfq2FAx+5zZ5hLjEioZXDyZESrXGifVAcmn+LE60RcwRVC27F0mVooW38FiqeLhUvP2c6aW4wFUfKVPZt7Z0S9RUxZOyyuTbY8K5DEbADELa5q+B1t+GmOqZSnTzTKHwKmxvU/Tt4TXcQ+NAK3V7ZAjdNTGyeWfNTBmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AouT7uUlxr+Mh8NWQ09M5uPAzgvCyc2PEEPQpHWDYig=;
 b=FP8eUSthKP2jyG18wV6HHwZeqwD/s11uOtb1qifEjShtqbVzw0khvj/zzo3SN+/B3dC6N+6r4QqK1Cnstmu34Vl68YmuGIvfOBm288LpN1qlGiRuU2PfgQTht9vkULD+6n4MKl3aoHosWUcjlVraBKwOApeNKt8px14GHPr/2hc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1788.namprd12.prod.outlook.com (2603:10b6:3:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Thu, 12 Mar
 2020 13:41:58 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2793.018; Thu, 12 Mar
 2020 13:41:58 +0000
Subject: Re: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close
To: "Liu, Monk" <Monk.Liu@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200312111203.81500-1-christian.koenig@amd.com>
 <MN2PR12MB39335E821319112A6D42CD1784FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
 <eb87e9c1-7e76-11a1-2aa9-fc719e28901c@gmail.com>
 <MN2PR12MB39337C7AFE4D925A877FC94184FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <58b21805-3cae-a189-6b8a-234151b73dee@amd.com>
Date: Thu, 12 Mar 2020 14:41:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MN2PR12MB39337C7AFE4D925A877FC94184FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0031.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::44) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR07CA0031.eurprd07.prod.outlook.com (2603:10a6:208:ac::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.9 via Frontend Transport; Thu, 12 Mar 2020 13:41:57 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08b0eb4c-5e39-49f8-57bd-08d7c68b2294
X-MS-TrafficTypeDiagnostic: DM5PR12MB1788:|DM5PR12MB1788:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1788653506B91B97D09DD68E83FD0@DM5PR12MB1788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(199004)(478600001)(6666004)(6486002)(66574012)(53546011)(966005)(31696002)(110136005)(2616005)(16526019)(66476007)(52116002)(86362001)(66946007)(186003)(66556008)(36756003)(81156014)(81166006)(8936002)(31686004)(2906002)(5660300002)(316002)(8676002)(45080400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1788;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bd5ckdO9xpaT2Yo0UmDhPjy83z1DFxXIisxy/8eybQoPsSHBdoUPk5fc6pYCfvCs/oROBwDXP4qpPMkBSzfYWLiVJqroEyZSZdUcOTSONN2+CMTLzCQ8dzKM1JGoMA4I0sYxE1lvm0m+z3KJ9QfAPg8HWWv67WDHX79lsrHEO+25E98jz6zaA30q8z57q+C2zGxik21/xh4bl3iGU5VUVlQm+xrX++zSkBVO3JpF3wtc28SzFe/kNHbX1/oXUHddRP9Ieg1cgjCEsgB7T2WqEJK1Bw3/pI+cxdD8N3F37LDgpmcLrnsJ/mrBtN/pzaiHBjeiflxXGnSwNOLw1IPFBnpAzOmXE/JHTG20dIHgJmgJiJgvNioUovN0oXPTHDavTABrqzZhQlD3r5eE21Kf95b2VGPbHOC0m4N2PDs7Guky6htlXRGSqrttzZxZwlHlmK846yclWki3BxiSUrDalehBDauiz8DOHKZxGxle/ARxn9LESs2XGU2adYXX8jjCOYE5yMu1MbTyUfYOVrcjToCAeOxNl7fWHcaBnPK3KV2Z7Fjnf5RFaoV6AwH9DbAkc5uHsQH1dq2PU22gM71nGJ12JAO0WubmBEkfpJUpEl8vAwVZwxggVQLRFpTQOGOl
X-MS-Exchange-AntiSpam-MessageData: AYvtkQ0OgFPn4CQh4k41/V+pYefbtEKQ8BJlbpzdp/wzL5d/dDuJ2/6MjZjsSqKbmSM/OCEniKt/rXvKixLEoSrrmJTuilS9SPZLdk8HdwLqZPI9bqLpT4Vqhsja/jsT8JA1rDiHatn51G4UKEq2Nw09+4bKTTb9rdUQ3nCB4vh347k8GlPoMGAzeVPNb5ladbbFWNurfmbB3uxvGIyXNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b0eb4c-5e39-49f8-57bd-08d7c68b2294
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 13:41:58.1884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDOJkFySaY8RK8Jlf+cXmvLBY1tkJEtJVHIBxYsOD4oRDhs9gChqMuEvnzL+r3A+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1788
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

VGhlIHByb2JsZW0gaXMgdGhhdCBkbWFfcmVzdl90ZXN0X3NpZ25hbGVkX3JjdSgpIHRlc3RzIG9u
bHkgdGhlIHNoYXJlZCAKZmVuY2UgaWYgb25lIGlzIHByZXNlbnQuCgpOb3cgd2hhdCBoYXBwZW5l
ZCBpcyB0aGF0IHRoZSBjbGVhciBmZW5jZSBjb21wbGV0ZWQgYmVmb3JlIHRoZSBleGNsdXNpdmUg
Cm9uZSwgYW5kIHRoYXQgaW4gdHVybiBjYXVzZWQgVFRNIHRvIHRoaW5rIHRoYXQgdGhlIEJPIGlz
IHVudXNlZCBhbmQgCmZyZWVkIGl0LgoKQ2hyaXN0aWFuLgoKQW0gMTIuMDMuMjAgdW0gMTQ6MjUg
c2NocmllYiBMaXUsIE1vbms6Cj4gd2l0aG91dCB5b3VyIHBhdGNoLCB0aGUgY2xlYXIgZmVuY2Ug
aXMgYWxzbyBob29rZWQgaW4gdGhlIHNoYXJlZCBsaXN0IG9mIGJvJ3MgcmVzZXJ2YXRpb24gb2Jq
LCAgbm8gbWF0dGVyIHRoZSBleGNsdXNpdmUgZmVuY2Ugb2YgdGhhdCBCTyBzaWduYWxlZCBiZWZv
cmUgY2xlYXIgZmVuY2Ugb3Igbm90Cj4KPiBzaW5jZSB0aGUgY2xlYXIgZmVuY2UgaXMgYWx3YXlz
IGtlcHQgaW4gdGhlIGJvJ3MgcmVzdiBvYmplY3QsIGNhbiB5b3UgdGVsbCBtZSB3aGF0J3MgdGhl
IHByb2JsZW0gdGhhbiA/IGFyZSB3ZSBnb2luZyB0byBsb29zZSB0aGlzIGNsZWFyIGZlbmNlIGFu
ZCBzdGlsbCB1c2UgaXQgZHVyaW5nIHRoZSAgVk0gcHQvcGQgY2xlYXJpbmcgPwo+Cj4gdGhhbmtz
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IE1vbmsgTGl1fEdQVSBW
aXJ0dWFsaXphdGlvbiBUZWFtIHxBTUQKPgo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0K
PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNv
bT4KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMTIsIDIwMjAgODo1MCBQTQo+IFRvOiBMaXUsIE1v
bmsgPE1vbmsuTGl1QGFtZC5jb20+OyBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0v
YW1kZ3B1OiBmaXggYW5kIGNsZWFudXAgYW1kZ3B1X2dlbV9vYmplY3RfY2xvc2UKPgo+ICAgRnJv
bSB0aGUgc2VtYW50aWMgdGhlIGRtYV9yZXN2IG9iamVjdCBjb250YWlucyBhIHNpbmdsZSBleGNs
dXNpdmUgYW5kIG11bHRpcGxlIHNoYXJlZCBmZW5jZXMgYW5kIGl0IGlzIG1hbmRhdG9yeSB0aGF0
IHRoZSBzaGFyZWQgZmVuY2VzIGNvbXBsZXRlIGFmdGVyIHRoZSBleGNsdXNpdmUgb25lLgo+Cj4g
Tm93IHdoYXQgaGFwcGVucyBpcyB0aGF0IGNsZWFyaW5nIHRoZSBWTSBwYWdlIHRhYmxlcyBydW5z
IGFzeW5jaHJvbm91c2x5IHRvIHRoZSBleGNsdXNpdmUgZmVuY2Ugd2hpY2ggbW92ZXMgdGhlIGJ1
ZmZlciBhcm91bmQuCj4KPiBBbmQgYmVjYXVzZSBvZiB0aGlzIFhpbmh1aSByYW4gaW50byBhIHJh
cmUgcHJvYmxlbSB0aGF0IFRUTSB0aG91Z2h0IGl0IGNvdWxkIHJldXNlIHRoZSBtZW1vcnkgd2hp
bGUgaW4gcmVhbGl0eSBpdCB3YXMgc3RpbGwgaW4gdXNlLgo+Cj4gUmVnYXJkcywKPiBDaHJpc3Rp
YW4uCj4KPiBBbSAxMi4wMy4yMCB1bSAxMjozMCBzY2hyaWViIExpdSwgTW9uazoKPj4gQ2FuIHlv
dSBnaXZlIG1vcmUgZGV0YWlscyBhYm91dCAiIHdlIGNhbid0IGd1YXJhbnRlZSB0aGUgdGhlIGNs
ZWFyIGZlbmNlIHdpbGwgY29tcGxldGUgYWZ0ZXIgdGhlIGV4Y2x1c2l2ZSBvbmUuIiA/Cj4+Cj4+
IFRoYW5rcwo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IE1v
bmsgTGl1fEdQVSBWaXJ0dWFsaXphdGlvbiBUZWFtIHxBTUQKPj4KPj4KPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mCj4+IENocmlzdGlhbiBLP25pZwo+PiBTZW50OiBU
aHVyc2RheSwgTWFyY2ggMTIsIDIwMjAgNzoxMiBQTQo+PiBUbzogUGFuLCBYaW5odWkgPFhpbmh1
aS5QYW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IFN1YmplY3Q6
IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGFuZCBjbGVhbnVwIGFtZGdwdV9nZW1fb2JqZWN0X2Ns
b3NlCj4+Cj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQgd2UgY2FuJ3QgYWRkIHRoZSBjbGVhciBmZW5j
ZSB0byB0aGUgQk8gd2hlbiB0aGVyZSBpcyBhbiBleGNsdXNpdmUgZmVuY2Ugb24gaXQgc2luY2Ug
d2UgY2FuJ3QgZ3VhcmFudGVlIHRoZSB0aGUgY2xlYXIgZmVuY2Ugd2lsbCBjb21wbGV0ZSBhZnRl
ciB0aGUgZXhjbHVzaXZlIG9uZS4KPj4KPj4gVG8gZml4IHRoaXMgcmVmYWN0b3IgdGhlIGZ1bmN0
aW9uIGFuZCB3YWl0IGZvciBhbnkgcG90ZW50aWFsIGV4Y2x1c2l2ZSBmZW5jZSB3aXRoIGEgc21h
bGwgdGltZW91dCBiZWZvcmUgYWRkaW5nIHRoZSBzaGFyZWQgY2xlYXIgZmVuY2UuCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
Pj4gLS0tCj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDQx
ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2Vy
dGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dlbS5jCj4+IGluZGV4IDQyNzcxMjVhNzllZS4uMDc4MjE2MmZiNWYzIDEwMDY0
NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+IEBAIC0xNjEsMTAg
KzE2MSwxMSBAQCB2b2lkIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlKHN0cnVjdAo+PiBkcm1fZ2Vt
X29iamVjdCAqb2JqLAo+PiAgICAKPj4gICAgCXN0cnVjdCBhbWRncHVfYm9fbGlzdF9lbnRyeSB2
bV9wZDsKPj4gICAgCXN0cnVjdCBsaXN0X2hlYWQgbGlzdCwgZHVwbGljYXRlczsKPj4gKwlzdHJ1
Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IE5VTEw7Cj4+ICAgIAlzdHJ1Y3QgdHRtX3ZhbGlkYXRlX2J1
ZmZlciB0djsKPj4gICAgCXN0cnVjdCB3d19hY3F1aXJlX2N0eCB0aWNrZXQ7Cj4+ICAgIAlzdHJ1
Y3QgYW1kZ3B1X2JvX3ZhICpib192YTsKPj4gLQlpbnQgcjsKPj4gKwlsb25nIHI7Cj4+ICAgIAo+
PiAgICAJSU5JVF9MSVNUX0hFQUQoJmxpc3QpOwo+PiAgICAJSU5JVF9MSVNUX0hFQUQoJmR1cGxp
Y2F0ZXMpOwo+PiBAQCAtMTgyLDI0ICsxODMsMzIgQEAgdm9pZCBhbWRncHVfZ2VtX29iamVjdF9j
bG9zZShzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiwKPj4gICAgCQlyZXR1cm47Cj4+ICAgIAl9
Cj4+ICAgIAlib192YSA9IGFtZGdwdV92bV9ib19maW5kKHZtLCBibyk7Cj4+IC0JaWYgKGJvX3Zh
ICYmIC0tYm9fdmEtPnJlZl9jb3VudCA9PSAwKSB7Cj4+IC0JCWFtZGdwdV92bV9ib19ybXYoYWRl
diwgYm9fdmEpOwo+PiArCWlmICghYm9fdmEgfHwgLS1ib192YS0+cmVmX2NvdW50KQo+PiArCQln
b3RvIG91dF91bmxvY2s7Cj4+ICAgIAo+PiAtCQlpZiAoYW1kZ3B1X3ZtX3JlYWR5KHZtKSkgewo+
PiAtCQkJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBOVUxMOwo+PiArCWFtZGdwdV92bV9ib19y
bXYoYWRldiwgYm9fdmEpOwo+PiArCWlmICghYW1kZ3B1X3ZtX3JlYWR5KHZtKSkKPj4gKwkJZ290
byBvdXRfdW5sb2NrOwo+PiAgICAKPj4gLQkJCXIgPSBhbWRncHVfdm1fY2xlYXJfZnJlZWQoYWRl
diwgdm0sICZmZW5jZSk7Cj4+IC0JCQlpZiAodW5saWtlbHkocikpIHsKPj4gLQkJCQlkZXZfZXJy
KGFkZXYtPmRldiwgImZhaWxlZCB0byBjbGVhciBwYWdlICIKPj4gLQkJCQkJInRhYmxlcyBvbiBH
RU0gb2JqZWN0IGNsb3NlICglZClcbiIsIHIpOwo+PiAtCQkJfQo+PiAgICAKPj4gLQkJCWlmIChm
ZW5jZSkgewo+PiAtCQkJCWFtZGdwdV9ib19mZW5jZShibywgZmVuY2UsIHRydWUpOwo+PiAtCQkJ
CWRtYV9mZW5jZV9wdXQoZmVuY2UpOwo+PiAtCQkJfQo+PiAtCQl9Cj4+IC0JfQo+PiArCXIgPSBh
bWRncHVfdm1fY2xlYXJfZnJlZWQoYWRldiwgdm0sICZmZW5jZSk7Cj4+ICsJaWYgKHIgfHwgIWZl
bmNlKQo+PiArCQlnb3RvIG91dF91bmxvY2s7Cj4+ICsKPj4gKwlyID0gZG1hX3Jlc3Zfd2FpdF90
aW1lb3V0X3JjdShiby0+dGJvLmJhc2UucmVzdiwgZmFsc2UsIGZhbHNlLAo+PiArCQkJCSAgICAg
IG1zZWNzX3RvX2ppZmZpZXMoMTApKTsKPj4gKwlpZiAociA9PSAwKQo+PiArCQlyID0gLUVUSU1F
RE9VVDsKPj4gKwlpZiAocikKPj4gKwkJZ290byBvdXRfdW5sb2NrOwo+PiArCj4+ICsJYW1kZ3B1
X2JvX2ZlbmNlKGJvLCBmZW5jZSwgdHJ1ZSk7Cj4+ICsJZG1hX2ZlbmNlX3B1dChmZW5jZSk7Cj4+
ICsKPj4gK291dF91bmxvY2s6Cj4+ICsJaWYgKHVubGlrZWx5KHIpKQo+PiArCQlkZXZfZXJyKGFk
ZXYtPmRldiwgImZhaWxlZCB0byBjbGVhciBwYWdlICIKPj4gKwkJCSJ0YWJsZXMgb24gR0VNIG9i
amVjdCBjbG9zZSAoJWQpXG4iLCByKTsKPj4gICAgCXR0bV9ldV9iYWNrb2ZmX3Jlc2VydmF0aW9u
KCZ0aWNrZXQsICZsaXN0KTsgIH0KPj4gICAgCj4+IC0tCj4+IDIuMTcuMQo+Pgo+PiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL25hbTEx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0
Cj4+IHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7
ZGF0YT0wMiU3QzAxJTdDTW8KPj4gbmsuTGl1JTQwYW1kLmNvbSU3QzI2NzMwZTU2YzViOTQ0Zjhj
YmI0MDhkN2M2ODNkNGExJTdDM2RkODk2MWZlNDg4NGU2MAo+PiA4ZTExYTgyZDk5NGUxODNkJTdD
MCU3QzAlN0M2MzcxOTYxNDE4MTU5Mjk5MTUmYW1wO3NkYXRhPXlQNVljMUJXWVdTOTNmCj4+IDBo
SEVSVWZFQ21TaHd5UTVmYk1raENlRzgybjZNJTNEJmFtcDtyZXNlcnZlZD0wCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
