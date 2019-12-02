Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE44C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 14:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FAC2071F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 14:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FAC2071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B6789F35;
	Mon,  2 Dec 2019 14:43:53 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720067.outbound.protection.outlook.com [40.107.72.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D604D89F35
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 14:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKZcHL0K5HPYQi7ywcwHmFmolAi+X4X7zUiOk/PF1nPa8xjVMKEf6eiXvLHLHwFngKx5MVmdCd6xEq4qW42jveE81HSq5a1tn7M265QaOWTr6WYwwWtcrJgYltuvuyOJlK3kHvNmD4Xj88w3Gw0C9uwu6IUssfB9tPd8jR70FzRHj9Xwvt7T4+F/++FcG79C7RzU09rs01PHSYSrFntmpn7BmIBWMFvuuIqJifzZ9B0c/uGxw2KLUl/jEZeEe2jixgPEgNe7Gs2tx7LVRznrXaJwrczPWEDY2S2YhKVkei0krBoQmP41cjQcZlb9KFouADhZiplgDdXmSS4+p4SEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt8d//1AxpsGi2zJN7vT5F3mcx18wAj3lpqDlbW/BLg=;
 b=WBIrkOC7LbCKRlJePTzc82QnlGuXABUabmSXgT4e2faSbIXTZ8NanDY3KYgd6gIczonYNgk/b3M1khh40AtJBMP3UmFfNiWRivjJhkQW5nN8n8+WB5V1FF5AA5Me0czRT4EIRY0rpYQ4MOfeMVar0ohuL/nax9PCE4hsrXd60Z406YstJDuIb220Ifv6rzRm0YsNcLNqSmDCjxIdCPhxn9Vu0Cu95GQH39d8xs5hSYPcI7l0tCLbPq8ymdCS9u7DdmIT1rss3yT/nojHvB6LbTS7vtpusOOZwymoBcpwo8WOsqyzwA0rb+xgu1sFy5S2J6J6zTChYEmQCpD9W1QV+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1484.namprd12.prod.outlook.com (10.172.40.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Mon, 2 Dec 2019 14:43:49 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a%7]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 14:43:48 +0000
Subject: Re: [RFC PATCH] drm/amdgpu: allocate entities on demand
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 alexander.deucher@amd.com, kenny.ho@amd.com
References: <20191125231719.108949-1-nirmoy.das@amd.com>
 <2e514ab3-1582-6508-d81a-cbc2d12f42d7@amd.com>
 <74fd0faf-fd99-e33e-8d7a-95f9bb8be26a@gmail.com>
 <4954a31a-dfbb-1432-9ffe-42ad9f89073c@amd.com>
 <b141b429-42ae-9640-d9eb-7ab243240ea2@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <8e74a3fb-6aff-38cb-5bc0-a60cdd05e5ff@amd.com>
Date: Mon, 2 Dec 2019 15:43:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
In-Reply-To: <b141b429-42ae-9640-d9eb-7ab243240ea2@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR0102CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::47) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-Originating-IP: [2003:c5:8f21:2000:2015:f2b2:853a:c0c9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1c94c24-e40b-4319-6aa4-08d777360a87
X-MS-TrafficTypeDiagnostic: DM5PR12MB1484:|DM5PR12MB1484:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1484BD60FC3873A3EAC4C4868B430@DM5PR12MB1484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(199004)(189003)(305945005)(7736002)(81156014)(81166006)(58126008)(8936002)(2906002)(14454004)(4326008)(46003)(6246003)(2616005)(52116002)(66574012)(478600001)(11346002)(446003)(229853002)(6666004)(5660300002)(65806001)(47776003)(31686004)(2870700001)(186003)(36756003)(65956001)(66556008)(6512007)(25786009)(14444005)(76176011)(6486002)(66946007)(6436002)(8676002)(66476007)(6116002)(316002)(53546011)(386003)(23676004)(6506007)(31696002)(2486003)(6636002)(50466002)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1484;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSKpBKbG7E5qWQsXvPYE34S6g873XkUQz67vBFpcUJIUtEWd+Q9/64K632l5DzQ0E8d3ovSkSWzm24soq1TWkq5UCe6FNvs7O3z9tpWpTMBIIw/7k08MFO41fj2+nT5Y52i0hypUiitiAYczcUFtaF4l45rAYKu7ysp8tmrgQRuyZwCO4ORll5fKhXTLg5VNWh6dLCY1kajidwazDCgAQYcxLFL16okNJ7mEaWGlNWZpIBxUg6b5sFagLU8hLOREYiVjg9saR2UDKnIIJwsCTsCm2pNDUCZC7zbm0H+HFvdYeLvOQs4/nrzqpwpZJeVU7yz2zDK4ELg0tMrPCegPBtcFISmDDPTmZVVygB1Tof9G145Eg4T0oMMJeh3/HJmjbVIyLF7tM0AwfF3K7cq/EAk6zFO61yUBKX3koiAW/JSoCwSgJlKg1Bzz1DnAAGAq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c94c24-e40b-4319-6aa4-08d777360a87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 14:43:48.7329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOYlPLTP0qMK0kUriBOngCzrw3g3TaIU7htd2SUb68QIc9Rn/uDkCoJLl0OLgBE67t25DzKMExtWmBydBz6A2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1484
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt8d//1AxpsGi2zJN7vT5F3mcx18wAj3lpqDlbW/BLg=;
 b=xHWfp7M8KDerOh8gIpLEP1oVnxrLU9H7rdcFAOhq2RRHUJBmX6W59xMr2fXjE6ZikMdNS3ywD7f6uQZbO9TwXSNLMgJS5lx2CPJgbPWLM67InZ3uVlmInjWmKcIKgZxbWWJFb0I21kz/iB9xhM2t0MrZzolqsNacE6H9CvmY1yQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDExLzI5LzE5IDc6NDIgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjkuMTEu
MTkgdW0gMTU6Mjkgc2NocmllYiBOaXJtb3k6Cj4+IEhpIENocmlzdGlhbiwKPj4KPj4gT24gMTEv
MjYvMTkgMTA6NDUgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBJdCBsb29rcyBsaWtl
IGEgc3RhcnQsIGJ1dCB0aGVyZSBudW1lcm91cyB0aGluZ3Mgd2hpY2ggbmVlZHMgdG8gYmUgCj4+
PiBmaXhlZC4KPj4+Cj4+PiBRdWVzdGlvbiBudW1iZXIgb25lIGlzOiBXaGF0J3MgdGhhdCBnb29k
IGZvcj8gRW50aXRpZXMgYXJlIG5vdCB0aGUgCj4+PiBwcm9ibGVtIGhlcmUuIFRoZSByZWFsIGlz
c3VlIGlzIHRoZSBmZW5jZSByaW5nIGFuZCB0aGUgcnFfbGlzdC4KPj4+Cj4+PiBUaGUgcnFfbGlz
dCBjb3VsZCBhY3R1YWxseSBiZSBtYWRlIGNvbnN0YW50IHNpbmNlIGl0IHNob3VsZCBuZXZlciBi
ZSAKPj4+IGNoYW5nZWQgYnkgdGhlIGVudGl0eS4gSXQgaXMgb25seSBjaGFuZ2VkIGZvciBiYWNr
d2FyZCBjb21wYXRpYmlsaXR5IAo+Pj4gaW4gZHJtX3NjaGVkX2VudGl0eV9zZXRfcHJpb3JpdHko
KS4KPj4+Cj4+PiBTbyBJIHdvdWxkIHN0YXJ0IHRoZXJlIGFuZCBjbGVhbnVwIHRoZSAKPj4+IGRy
bV9zY2hlZF9lbnRpdHlfc2V0X3ByaW9yaXR5KCkgdG8gYWN0dWFsbHkganVzdCBzZXQgYSBuZXcg
Y29uc3RhbnQgCj4+PiBycSBsaXN0IGluc3RlYWQuCj4+Cj4+IEkgYW0gbWlzc2luZyBzb21lIGNv
bnRleHQgaGVyZS4gQ2FuIHlvdSBwbGVhc2UgZXhwbGFpbiBiaXQgbW9yZT8gSSAKPj4gbG9va2Vk
IG92ZXIgYW5kIG92ZXIgYWdhaW4gYnV0IEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IGRv
IHlvdSAKPj4gbWVhbiBiecKgIG5ldyBjb25zdGFudCBycSBsaXN0IDovCj4KPiBPayB0aGF0IG5l
ZWRzIGEgYml0IHdpZGVyIGV4cGxhbmF0aW9uLgo+Cj4gVGhlIEdQVSBzY2hlZHVsZXIgY29uc2lz
dHMgbWFpbmx5IG9mIGRybV9ncHVfc2NoZWR1bGVyIGluc3RhbmNlcy4gRWFjaCAKPiBvZiB0aG9z
ZSBpbnN0YW5jZXMgY29udGFpbiBtdWx0aXBsZSBydW5xdWV1ZXMgd2l0aCBkaWZmZXJlbnQgCj4g
cHJpb3JpdGllcyAoNSBJSVJDKS4KPgo+IE5vdyBmb3IgZWFjaCBlbnRpdHkgd2UgZ2l2ZSBhIGxp
c3Qgb2YgcnVucXVldWVzIHdoZXJlIHRoaXMgZW50aXR5IGNhbiAKPiBiZSBzZXJ2ZWQgb24sIGUu
Zy4gd2hlcmUgdGhlIGpvYnMgd2hpY2ggYXJlIHB1c2hlZCB0byB0aGUgZW50aXRpZXMgYXJlIAo+
IGV4ZWN1dGVkLgo+Cj4gVGhlIGVudGl0eSBpdHNlbGYga2VlcHMgYSBjb3B5IG9mIHRoYXQgcnVu
cXVldWUgbGlzdCBiZWNhdXNlIHdlIGhhdmUgCj4gdGhlIGRybV9zY2hlZF9lbnRpdHlfc2V0X3By
aW9yaXR5KCkgd2hpY2ggbW9kaWZpZXMgdGhpcyBydW5xdWV1ZSBsaXN0Lgo+Cj4gQnV0IGVzc2Vu
dGlhbGx5IHRoYXQgaXMgY29tcGxldGUgb3ZlcmtpbGwsIHRoZSBydW5xdWV1ZSBsaXN0cyBhcmUg
Cj4gY29uc3RhbnQgZm9yIGVhY2ggYW1kZ3B1IGRldmljZSwgZS5nLiBhbGwgY29udGV4dHMgc2hv
dWxkIHVzZSBTRE1BMCAKPiBhbmQgU0RNQTEgaW4gdGhlIHNhbWUgd2F5Lgo+Cj4gSW4gb3RoZXIg
d29yZHMgYnVpbGRpbmcgdGhlIGxpc3Qgb24gcnVucXVldWVzIHNob3VsZCBoYXBwZW4gb25seSBv
bmNlIAo+IGFuZCBub3QgZm9yIGVhY2ggY29udGV4dHMuCk9rYXkgSSB1bmRlcnN0YW5kIG5vdyB0
aGUgcmVhbCBwcm9ibGVtLiBUaGFua3MgZm9yIGRldGFpbCBleHBsYW5hdGlvbi4KPgo+IE11bHRp
cGxlIGFwcHJvYWNoIHRvIGZpeCB0aGlzIHdvdWxkIGJlIHBvc3NpYmxlLiBPbmUgcmF0aGVyIGVs
ZWdhbnQgCj4gc29sdXRpb24gd291bGQgYmUgdG8gY2hhbmdlIHRoZSBycSBsaXN0IGludG8gYSBz
Y2hlZHVsZXIgaW5zdGFuY2VzIAo+IGxpc3QgKyBwcmlvcml0eS4KCkRvIHlvdSBtZWFuIHNvbWV0
aGluZyBsaWtlCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oIGIvaW5j
bHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCmluZGV4IDY4NDY5MmE4ZWQ3Ni4uYWM2N2Y4ZjA5OGZh
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgKKysrIGIvaW5jbHVkZS9k
cm0vZ3B1X3NjaGVkdWxlci5oCkBAIC04MSw3ICs4MSw3IEBAIGVudW0gZHJtX3NjaGVkX3ByaW9y
aXR5IHsKIMKgc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgewogwqDCoMKgwqDCoMKgwqAgc3RydWN0
IGxpc3RfaGVhZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsaXN0OwogwqDCoMKgwqDC
oMKgwqAgc3RydWN0IGRybV9zY2hlZF9yccKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqcnE7Ci3C
oMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9yccKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
KnJxX2xpc3Q7CivCoMKgwqDCoMKgIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlcsKgwqDCoMKgwqDC
oMKgICoqc2NoZWQ7CiDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnTCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudW1fcnFfbGlzdDsKIMKgwqDCoMKgwqDCoMKgIHNwaW5s
b2NrX3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcnFfbG9jazsK
Cj4KPgo+IFRoaXMgd2F5IHdlIHdvdWxkIGFsc28gZml4IHRoZSBhZ2Ugb2xkIGJ1ZyB0aGF0IGNo
YW5naW5nIHRoZSBwcmlvcml0eSAKPiBvZiBhIGNvbnRleHQgY291bGQgYWN0dWFsbHkgbWVzcyB1
cCBhbHJlYWR5IHNjaGVkdWxlZCBqb2JzLgo+Cj4gVGhlIGFsdGVybmF0aXZlIEkgbm90ZWQgYmVm
b3JlIHdvdWxkIGJlIHRvIGRyb3AgCj4gZHJtX3NjaGVkX2VudGl0eV9zZXRfcHJpb3JpdHkoKSBv
ciBjaGFuZ2UgaXQgaW50byAKPiBkcm1fc2NoZWRfZW50aXR5X3NldF9ydW5xdWV1ZXMoKS4KSSB3
YXMgd29ya2luZyBvbiBpdCBidXQgdGhlbiBJIGdvdCBzdHVjayBieSBhwqAgIkJVRzoga2VybmVs
IE5VTEwgcG9pbnRlciAKZGVyZWZlcmVuY2UsIGFkZHJlc3M6IiB3aGljaCBJIGFtIHRyeWluZyB0
byBmaWd1cmUgb3V0IHdoeQo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPj4KPj4+Cj4+PiBU
aGVuIHdlIGNvdWxkIGVtYmVkIHRoZSBmZW5jZXMgaW4gYW1kZ3B1X2N0eF9lbnRpdHkgYXMgZHlu
YW1pYyBhcnJheSAKPj4+IGF0IHRoZSBlbmQgb2YgdGhlIHN0cnVjdHVyZS4KPj4+Cj4+PiBBbmQg
bGFzdCB3ZSBjYW4gc3RhcnQgdG8gZHluYW1pYyBhbGxvY2F0ZSBhbmQgaW5pdGlhbGl6ZSB0aGUg
Cj4+PiBhbWRncHVfY3R4X2VudGl0eSgpIHN0cnVjdHVyZXMuCj4+Pgo+Pj4gUmVnYXJkcywKPj4+
IENocmlzdGlhbi4KPj4+Cj4+Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
