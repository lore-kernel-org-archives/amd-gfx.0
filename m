Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE785C00454
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 15:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8083D2073B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 15:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zmD9W3F/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8083D2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FBA06E0FC;
	Tue, 10 Dec 2019 15:08:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A3F6E0FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 15:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4tFljvukc3/hPFA99WBFD5O2NfHsGE8vHrgtahvpKOPPHHlv8VzV3CtVbjYCQ8aR40zfZd1QoFOXwpPczKKY7ANonrea6/ok62GA4616iBol7/D3/66WMXm3EcQUAnr3EM6CkB1LlDINyZMZAHARxP3DswktLNwXqncd+AxQ308s7dmO8OxYulcTz+RCe0i7MCK1Nsd0rtBBy6zLfgyIotLuL3dLJTH8GJPWwkWvrH0miOLanwD5NAXk9qtebZhl7c6U1Z/OkK1IkTpjSBZFpqYm46phrtK3JG23rHF+nHACwy2F1TugDSxzQXEXf1eKLzVDh649sDry0eelPmz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSLSowv1Em2lIG05egODnwSXqC3vlWHjzDf+ClSSzl4=;
 b=Am8A7wpUbz4i3KCWM98vd1QWybSa4X84cslr3yi3rM+MInSCPYHMIPG4PEH4YMMx1lAb/IyVRCYflAmINcE9EFobU7jGa4q4ahmWf1nmRH9vdJyP46SeWWXkrAERP8kPE4zZ693K883bhDZDRm/JQUBEB8DapZFtmOAXMP3+mCEQ3A8rqvvYJPZQBv+/zY3UGwAlYWnOUDyefN21EwsGqbknPsfBTz6zsEXp2tqfxsPhPzWHDT31ctW191VNuLDqaRKumUV5bgLnz8cWj2ckv8nm7CNORbuxXcA17TkAL0SSYwbIpYG/N7mOFZ/epnreRQfLM5fhiOj+3P7Uq7sDrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSLSowv1Em2lIG05egODnwSXqC3vlWHjzDf+ClSSzl4=;
 b=zmD9W3F/p33+B5Vq0iIuhylQslHEDS8Zs1nF+AK981gfFj1HP4RaL5d3NgpKnI5w/AqYtzz8pcOKg4YgAb5KEXN5xgo7Ozm1VIvh7n3UYv07tlDFLCtoteGbDw9K9Tz+2sriYYrSOmadXxdVNBlNbMCUVhrSqOt7/hXR4hwCxwE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1657.namprd12.prod.outlook.com (10.172.38.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 15:08:32 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 15:08:32 +0000
Subject: Re: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
From: Nirmoy <nirmodas@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 alexander.deucher@amd.com, kenny.ho@amd.com
References: <20191210125300.3800-1-nirmoy.das@amd.com>
 <20191210125300.3800-4-nirmoy.das@amd.com>
 <800c29bf-11dd-0ac9-32ad-ef3476f07643@amd.com>
 <97343695-4b6d-1dfb-2c52-e728a7f1736e@amd.com>
Message-ID: <e5c038e1-9a5b-c37b-832c-4d6c92f2a528@amd.com>
Date: Tue, 10 Dec 2019 16:08:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <97343695-4b6d-1dfb-2c52-e728a7f1736e@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0029.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::42) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-Originating-IP: [2003:c5:8f2c:cf00:f7ef:6dd5:8f2d:73fd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: edb78e61-1e17-413e-b963-08d77d82d1f4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1657:|DM5PR12MB1657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1657D3166EBD202E3F17072F8B5B0@DM5PR12MB1657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(31686004)(8936002)(2616005)(66476007)(6512007)(186003)(53546011)(52116002)(4326008)(6486002)(2906002)(6506007)(8676002)(31696002)(5660300002)(6636002)(81166006)(81156014)(316002)(66556008)(478600001)(36756003)(66946007)(66574012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1657;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdDQKBQxzx/6ryI8w2sOZ7h2MzD8pa1TQ0KNuI55UlBTMgfDdDrTPXiAFgO2IJvnovbnVu9lVfpN6tMfVUCvd1KP/O1hgLduVHenhCQXgawAilMe7w9z1lLMO96LKIv1kfKOr/wOuX8ofyMgw0yu5v3is0rlZhgi/NEHSut92yLk3buN9kaQRnhzVwF3eiLq/DcMWx94TVftdoWImsHvNsa182gBpyEX5hONXOaHK3c0ZDoVeYEyX9+8Fd5pH2yC7unYeAc2CtUL3E6ctcT6Z9Tqjj9ot3lHHjzUibZvgCMzjRgmPajt67S2yFBa5Lw8DjUXcckxnYKUWmY5r24/SO9HgbFQ8ktBAscijMo7RnQ3Q+8FJKsFoq/uhymFXLzj6NRBSNsDFXthPCUFFRvcy018JPUDstoX7tMAUNttjpU46sIxds4buuPwwbKJbT9m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb78e61-1e17-413e-b963-08d77d82d1f4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 15:08:31.9630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rb9f+n1WmXysSE2Z+5SLoqqTM8yjRojirvCzNdplgXg1YGXMk7Ejd7zTeExMoAgwveCrJU3qf3BcQNma+VvMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSB0aGluayBhbWRncHVfY3R4X2luaXQoKSBzaG91bGQgY2hlY2sgZm9yIG51bV9zY2hlZHMgYW5k
IG5vdCBjYWxsIApkcm1fc2NoZWRfZW50aXR5X2luaXQoKQoKaWYgaXRzIHplcm8uCgpPbiAxMi8x
MC8xOSAzOjQ3IFBNLCBOaXJtb3kgd3JvdGU6Cj4KPiBPbiAxMi8xMC8xOSAyOjAwIFBNLCBDaHJp
c3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAxMC4xMi4xOSB1bSAxMzo1MyBzY2hyaWViIE5pcm1v
eSBEYXM6Cj4+PiBlbnRpdHkgc2hvdWxkIG5vdCBrZWVwIGNvcHkgYW5kIG1haW50YWluIHNjaGVk
IGxpc3QgZm9yCj4+PiBpdHNlbGYuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8
bmlybW95LmRhc0BhbWQuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1
bGVyL3NjaGVkX2VudGl0eS5jIHwgMTAgKy0tLS0tLS0tLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCA5IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+PiBpbmRleCBmOWI2Y2UyOWM1OGYuLmE1Zjcy
OWY0MjFmOCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRf
ZW50aXR5LmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5
LmMKPj4+IEBAIC02NywxNyArNjcsMTAgQEAgaW50IGRybV9zY2hlZF9lbnRpdHlfaW5pdChzdHJ1
Y3QgCj4+PiBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHksCj4+PiDCoMKgwqDCoMKgIGVudGl0eS0+
Z3VpbHR5ID0gZ3VpbHR5Owo+Pj4gwqDCoMKgwqDCoCBlbnRpdHktPm51bV9zY2hlZF9saXN0ID0g
bnVtX3NjaGVkX2xpc3Q7Cj4+PiDCoMKgwqDCoMKgIGVudGl0eS0+cHJpb3JpdHkgPSBwcmlvcml0
eTsKPj4+IC3CoMKgwqAgZW50aXR5LT5zY2hlZF9saXN0ID3CoCBrY2FsbG9jKG51bV9zY2hlZF9s
aXN0LAo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXpl
b2Yoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICopLCBHRlBfS0VSTkVMKTsKPj4+ICvCoMKgwqAg
ZW50aXR5LT5zY2hlZF9saXN0ID3CoCBzY2hlZF9saXN0Owo+Pgo+PiBNYXliZSBtYWtlIHRoaXMg
Im51bV9zY2hlZF9saXN0ID4gMSA/IHNjaGVkX2xpc3QgOiBOVUxMIiB0byBhdm9pZCAKPj4gYWNj
aWRlbnRhbGx5IGRlcmVmZXJlbmNpbmcgYSBzdGFsZSBwb2ludGVyIHRvIHRoZSBzdGFjay4KPiBE
byB5b3UgbWVhbiAibnVtX3NjaGVkX2xpc3QgPj0gMSA/IHNjaGVkX2xpc3QgOiBOVUxMIgo+Pgo+
Pj4gwqAgLcKgwqDCoCBpZighZW50aXR5LT5zY2hlZF9saXN0KQo+Pj4gLcKgwqDCoMKgwqDCoMKg
IHJldHVybiAtRU5PTUVNOwo+Pj4gwqAgwqDCoMKgwqDCoCBpbml0X2NvbXBsZXRpb24oJmVudGl0
eS0+ZW50aXR5X2lkbGUpOwo+Pj4gLQo+Pj4gLcKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgbnVtX3Nj
aGVkX2xpc3Q7IGkrKykKPj4+IC3CoMKgwqDCoMKgwqDCoCBlbnRpdHktPnNjaGVkX2xpc3RbaV0g
PSBzY2hlZF9saXN0W2ldOwo+Pj4gLQo+Pj4gwqDCoMKgwqDCoCBpZiAobnVtX3NjaGVkX2xpc3Qp
Cj4+Cj4+IFRoYXQgY2hlY2sgY2FuIGFjdHVhbGx5IGJlIGRyb3BwZWQgYXMgd2VsbC4gV2UgcmV0
dXJuIC1FSU5WQUwgd2hlbiAKPj4gdGhlIG51bV9zY2hlZF9saXN0IGlzIHplcm8uCj4KPiBUaGlz
wqAgb25lIHRvb2sgbWUgc29tZSB0aW1lIHRvIHVuZGVyc3RhbmQuIFNvIHdlIGRvbid0IHJlYWxs
eSByZXR1cm4gCj4gLUVJTlZBTCBpZiBudW1fc2NoZWRfbGlzdCA9PSAwCj4KPiBpZiAoIShlbnRp
dHkgJiYgc2NoZWRfbGlzdCAmJiAobnVtX3NjaGVkX2xpc3QgPT0gMCB8fCBzY2hlZF9saXN0WzBd
KSkpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Cj4g
VGhpcyBpcyBjb21pbmcgZnJvbSBiZWxvdyBwYXRjaC4gQXJlIHdlIHN1cHBvc2UgdG8gdG9sZXJh
dGUgSVBzIHdpdGggCj4gdW5pbml0aWFsaXplZCBzY2hlZCBzbyB0aGF0IGN0eCBjcmVhdGlvbiBk
b3NuJ3QgcmV0dXJuIGVycm9yID8KPgo+IGNvbW1pdCAxZGVjYmY2YmIwYjRkYzU2YzlkYTZjNWU1
N2I5OTRlYmZjMmJlM2FhCj4gQXV0aG9yOiBCYXMgTmlldXdlbmh1aXplbiA8YmFzQGJhc25pZXV3
ZW5odWl6ZW4ubmw+Cj4gRGF0ZTrCoMKgIFdlZCBKYW4gMzAgMDI6NTM6MTkgMjAxOSArMDEwMAo+
Cj4gwqDCoMKgIGRybS9zY2hlZDogRml4IGVudGl0aWVzIHdpdGggMCBycXMuCj4KPiDCoMKgwqAg
U29tZSBibG9ja3MgaW4gYW1kZ3B1IGNhbiBoYXZlIDAgcnFzLgo+Cj4gwqDCoMKgIEpvYiBjcmVh
dGlvbiBhbHJlYWR5IGZhaWxzIHdpdGggLUVOT0VOVCB3aGVuIGVudGl0eS0+cnEgaXMgTlVMTCwK
PiDCoMKgwqAgc28gam9icyBjYW5ub3QgYmUgcHVzaGVkLiBXaXRob3V0IGEgcnEgdGhlcmUgaXMg
bm8gc2NoZWR1bGVyIHRvCj4gwqDCoMKgIHBvcCBqb2JzLCBhbmQgcnEgc2VsZWN0aW9uIGFscmVh
ZHkgZG9lcyB0aGUgcmlnaHQgdGhpbmcgd2l0aCBhCj4gwqDCoMKgIGxpc3Qgb2YgbGVuZ3RoIDAu
Cj4KPiDCoMKgwqAgU28gdGhlIG9wZXJhdGlvbnMgd2UgbmVlZCB0byBmaXggYXJlOgo+IMKgwqDC
oMKgwqAgLSBDcmVhdGlvbiwgZG8gbm90IHNldCBycSB0byBycV9saXN0WzBdIGlmIHRoZSBsaXN0
IGNhbiBoYXZlIAo+IGxlbmd0aCAwLgo+IMKgwqDCoMKgwqAgLSBEbyBub3QgZmx1c2ggYW55IGpv
YnMgd2hlbiB0aGVyZSBpcyBubyBycS4KPiDCoMKgwqDCoMKgIC0gT24gZW50aXR5IGRlc3RydWN0
aW9uIGhhbmRsZSB0aGUgcnEgPSBOVUxMIGNhc2UuCj4gwqDCoMKgwqDCoCAtIG9uIHNldF9wcmlv
cml0eSwgZG8gbm90IHRyeSB0byBjaGFuZ2UgdGhlIHJxIGlmIGl0IGlzIE5VTEwuCj4KPj4KPj4g
UmVnYXJkcywKPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVudGl0eS0+
cnEgPSAKPj4+ICZlbnRpdHktPnNjaGVkX2xpc3RbMF0tPnNjaGVkX3JxW2VudGl0eS0+cHJpb3Jp
dHldOwo+Pj4gwqAgQEAgLTMxMiw3ICszMDUsNiBAQCB2b2lkIGRybV9zY2hlZF9lbnRpdHlfZmlu
aShzdHJ1Y3QgCj4+PiBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHkpCj4+PiDCoCDCoMKgwqDCoMKg
IGRtYV9mZW5jZV9wdXQoZW50aXR5LT5sYXN0X3NjaGVkdWxlZCk7Cj4+PiDCoMKgwqDCoMKgIGVu
dGl0eS0+bGFzdF9zY2hlZHVsZWQgPSBOVUxMOwo+Pj4gLcKgwqDCoCBrZnJlZShlbnRpdHktPnNj
aGVkX2xpc3QpOwo+Pj4gwqAgfQo+Pj4gwqAgRVhQT1JUX1NZTUJPTChkcm1fc2NoZWRfZW50aXR5
X2ZpbmkpOwo+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
