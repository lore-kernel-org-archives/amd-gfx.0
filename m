Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D88DC3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 20:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2482073B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 20:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V6S3jy4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2482073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98C8689E2C;
	Tue,  3 Mar 2020 20:04:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA8DD89E2C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 20:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sxwk/sMXQXk3cj9kfXX/goCZirZLPJKzpbQSXrkD0sDF1QWAdxjLBJtN+0jRlX054oTr7w4wEyewWDTtuL43lCAkAmrxYDUAZr30Zx09rwBopaqoF4l69gRp84tjQV0uABa2q15kWckymUKFvnBdQejVJqOTi3keNHNC/g428jf7mdIpn+CPeg0ubev/jfNinRksXs6SLDYHV924LAm/HoqUp2rj3m+b0RF4F3bw/6WVNO4dl1I6rJO4M9aq49B+mJ5NKxh7vFhie0LA5b6Qz7mqDGTOj66xBfD2mYcOQX4MylPNQjB/nzZsKXZMQoXYEkZ4Ob5JpSKW80ofRXACIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vq3iKoqvBwza4+8qME8l3CfxwoegUxcZ3cg3zcTtzMc=;
 b=cVFYNFRbquiLqLswvg/W1WPWBj/d+39DkxxC9ZynufWQhtWHb6NE8ke2JZwoEu8cCQZkRoZv56h2lzUGcphJQYARkUCW8oHEX+Le1XhFE2hYGlwewblxy20Inkytvyi38kx2rWWkV/xZJyf4DGQIeZ71xGC9GtqECJPcN0zqiuzGQe92PO2WfkWsZhnQzJQdLoDCg/tQoJcIWqPnn+l/igmJIBQTRV5Cw20sntyOIVBgS7PFDYQxRHw4bYn9kPSEdg8KliNR4FgOnYBO0pmY8w8dOoXugkJyUrt7QvayK6BdAHgf9DdAqbDfM2qgSdpwkMDpBsQKCrAJ40YOaEXEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vq3iKoqvBwza4+8qME8l3CfxwoegUxcZ3cg3zcTtzMc=;
 b=V6S3jy4SE0DXzN93ztx0qt4gHZHy+bEnwWa1UAN/BGL3Rm0afa0QLB+Fbf8rgcqWnknVbQKhld+ljSFL2OQ3pspY+UUsP+i81RGVXqa1iViiA4uVMztQbtpvNeVM1PEcTLsDpkL+pNqN08eoA6ZJVQVaTDp39Ri/7tEJKgfoHHU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3738.namprd12.prod.outlook.com (2603:10b6:5:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 20:04:18 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 20:04:18 +0000
Subject: Re: [RFC PATCH 2/4] drm/scheduler: implement a function to modify
 sched list
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200227214012.3383-1-nirmoy.das@amd.com>
 <20200227214012.3383-2-nirmoy.das@amd.com>
 <46106fdd-55ed-cb09-902e-a1c0cffd7b0d@amd.com>
 <d87c9952-1eb8-5295-a1bc-475f5e94fc78@amd.com>
 <069d5a87-9792-87e5-432a-6c6456beeed6@amd.com>
 <21eef828-c01e-0c39-12cf-42cad5af8ed2@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <4f7810fe-3afe-97a9-56c8-ffd1662aab26@amd.com>
Date: Tue, 3 Mar 2020 15:04:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <21eef828-c01e-0c39-12cf-42cad5af8ed2@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::45) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Tue, 3 Mar 2020 20:04:17 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 566caa01-e27c-4fa7-f880-08d7bfae0e2c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3738:|DM6PR12MB3738:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3738F320C53C83DF066D04E199E40@DM6PR12MB3738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(8936002)(53546011)(478600001)(4326008)(26005)(6486002)(31696002)(31686004)(36756003)(8676002)(52116002)(16526019)(86362001)(186003)(66574012)(81156014)(44832011)(81166006)(6666004)(2616005)(956004)(16576012)(316002)(66946007)(66556008)(66476007)(2906002)(5660300002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3738;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZzRCbhKZzuJTmh2xrfsPNOI0L/k0TF6puaVxg8Wyj/JrhSlC3IOT93bHzz0+MTWzs0mxegM+Mr0VkdJp5tXw1RcqIBmxTD+Wiqafub2Ah4FylqLJ9ByNskrHDh9gYP4Ydw1SJOmQUidgM2MU1HAb2zfJGzwBUHBpRzCrwmic1Ra60Gwmpoj6HMQKfR7O14xWYbgrLD5IbL1rctnPbK10CtWIqMfY7UUi+q22W8EZdvj3lQh2Bbs0SN8/pX6kogdF7g10LBAmTq4HZcXZ/m+F5yB/JT3fYqGH9WD4OOGTjd2KHjmlmpm9iaK4ie/zp36nDPGFK/Oeb2Oxv36o1AQXwlsichbRFd0BhDlE8qgI64Gc8DLCHoGKHjtyNFYKV8QSLPO9xS8Q3Y08wAl7ymA6/+PCmvO60x0eGGQCHFMSJaUsSr4E8jpw7yggN0JpZzV
X-MS-Exchange-AntiSpam-MessageData: NzrD1aMI3jdMfwVOyJ8S9q4kQ77ALakiokSQ+5AATqWK6wW0CaOgYv/To+RM6FlId0XGUVWhe6+r0MDNNRoEhKp8Qy9MeNENzBVMD2DvklhNEnz123GDM7o27geS6Z+cVHoBa1Kw5gzLrISG5J9PjA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566caa01-e27c-4fa7-f880-08d7bfae0e2c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 20:04:18.1186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YmOHQe7Bzjt7EDeQ2//YbfMQ3kwWbR/fciYmmZX+REhVHXlieIUj5gwFkN+JWGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3738
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMy0wMyAxNDowNiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwMi4wMy4y
MCB1bSAyMTo0NyBzY2hyaWViIEx1YmVuIFR1aWtvdjoKPj4gT24gMjAyMC0wMi0yOCAyOjQ3IGEu
bS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAyOC4wMi4yMCB1bSAwNjowOCBzY2hy
aWViIEx1YmVuIFR1aWtvdjoKPj4+PiBPbiAyMDIwLTAyLTI3IDQ6NDAgcC5tLiwgTmlybW95IERh
cyB3cm90ZToKPj4+Pj4gW1NOSVBdCj4+Pj4+ICsJaWYgKCEoZW50aXR5ICYmIHNjaGVkX2xpc3Qg
JiYgKG51bV9zY2hlZF9saXN0ID09IDAgfHwgc2NoZWRfbGlzdFswXSkpKQo+Pj4+PiArCQlyZXR1
cm4gLUVJTlZBTDsKPj4+PiBUaGlzIHNlZW1zIHVubWFpbnRhaW5hYmxlLiBJJ2Qgd3JpdGUgaXQg
aW4gaXRzIG5hdHVyYWwgZm9ybToKPj4+IFRoaXMgaXMgcHJvYmFibHkganVzdCBjb3B5ICYgcGFz
dGVkIGZyb20gdGhlIGluaXQgZnVuY3Rpb24gYW5kIGNvbXBsZXRlCj4+PiBvdmVya2lsbCBoZXJl
Lgo+PiBJdCBzaG91bGQgYmUgYW4gZWFzeSByZWplY3Rpb24gdGhlbi4gU3RhdGVtZW50cyBsaWtl
IHRoaXMgbWFrZQo+PiB0aGUgY29kZSB1bm1haW50YWluYWJsZS4gUmVnYXJkbGVzcyBvZiB3aGV0
aGVyIGl0IHdhcyBjb3B5LWFuZC1wYXN0ZWQKPj4gSSB3YW50ZWQgdG8gZW1waGFzaXplIHRoZSBs
YWNrIG9mIHNpbXBsaWZpY2F0aW9uIG9mIHdoYXQKPj4gd2FzIGJlaW5nIGRvbmUuCj4gCj4gVGhl
IHByb2JsZW0gaXMgZXZlbiBkZWVwZXIuIEFzIHlvdSBub3RpY2VkIGFzIHdlbGwgdGhpcyBpcyBj
aGVja2luZyBmb3IgCj4gaW4ga2VybmVsIGNvZGluZyBlcnJvciBhbmQgbm90IGFwcGxpY2F0aW9u
IGVycm9ycy4KCldlIHNob3VsZG4ndCBjaGVjayB0aGUgaW4ta2VybmVsIGltcGxlbWVudGF0aW9u
IGl0c2VsZi4gSWYgdGhlIGtlcm5lbApkaWQgdGhpcyBldmVyeXdoZXJlLCBpdCdkIGJlIHR3aWNl
IHRoZSBzaXplLiBUaGUga2VybmVsIHNob3VsZG4ndCBiZQpzZWNvbmQtZ3Vlc3NpbmcgaXRzZWxm
LgoKQW5vdGhlciB3YXkgdG8gc2VlIHRoaXMgaXMgdG8gYXNrICJ3aGF0IHdvdWxkIHRoZSBrZXJu
ZWwgZG8gaGVyZQppZiBYWVogd2FzIE5VTEwiLCBmb3IgaW5zdGFuY2U/ICBGb3IgdXNlcnNwYWNl
LCBpdCdzIGNsZWFyLiBGb3IKdGhlIGtlcm5lbCwgaXQgc2hvd3MgaW5jb25zaXN0ZW50IGFuZCBp
bmNvbXBsZXRlIGltcGxtZW50YXRpb24tLXNvbWV0aGluZwp3aGljaCBzaG91bGQgYmUgZml4ZWQu
CgpBbm90aGVyIHdheSBvZiBzZWVpbmcgdGhpcyBpcywgaWYgeW91IGJyZWFrIG91dCBhIGZ1bmN0
aW9uIGludG8gc2VwYXJhdGUKc21hbGxlciBmdW5jdGlvbnMsIGNoZWNraW5nIHRoZSBpbnB1dCBw
YXJhbWV0ZXJzIGluIHRob3NlIGxlYWYvaGVscGVyCmZ1bmN0aW9ucyAoY29kZSB3aGljaCBoYWQg
YmVlbiBwYXJ0IG9mIHRoZSBvcmlnaW5hbCBiaWcgZnVuY3Rpb24pLCB3b3VsZAptYWtlIHRoZSBj
b2RlIGxhcmdlciBhbmQgc2Vjb25kLWd1ZXNzaW5nIGl0c2VsZi4KClRoYXQgY2hlY2sgc2hvdWxk
bid0IGJlIHRoZXJlLiBUaGUgaW1wbGVtZW50YXRpb24gc2hvdWxkIGJlIGNvbnNpc3RlbnQKYW5k
IGNvbXBsZXRlIGluIG9yZGVyIHRvIHNob3cgYW4gZWxlZ2FudCBjb2RlLgoKPiAKPiBUaGF0IGNo
ZWNrIHNob3VsZG4ndCBoYXZlIGJlZW4gaW4gdGhlIGluaXQgZnVuY3Rpb24gaW4gdGhlIGZpcnN0
IHBsYWNlLCAKPiBidXQgbm9ib2R5IGhhZCB0aW1lIHRvIGxvb2sgaW50byB0aGF0IHNvIGZhci4K
PiAKPj4gV2UgbmVlZCB0byBwdXQgaW50ZW50aW9uIGFuZCBzZW5zZSBpbnRvIHdoYXQgd2UncmUg
ZG9pbmcsIHNjcnV0aW5pemluZwo+PiBldmVyeSBsaW5lIHdlIHB1dCBpbnRvIGEgcGF0Y2guIFRo
aXMgaXMgd2h5IEkgc3VnZ2VzdGVkCj4+IHRoZSBzaW1wbGlmaWNhdGlvbiBoZXJlOgo+Pgo+Pj4+
IGludCBkcm1fc2NoZWRfZW50aXR5X21vZGlmeV9zY2hlZChzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0
eSAqZW50aXR5LAo+Pj4+IAkJCQkgIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqKnNjaGVkX2xp
c3QsCj4+Pj4gCQkJCSAgdW5zaWduZWQgaW50IG51bV9zY2hlZF9saXN0KQo+Pj4+IHsKPj4+PiAJ
aWYgKGVudGl0eSAmJiBzY2hlZF9saXN0ICYmIChudW1fc2NoZWRfbGlzdCA9PSAwIHx8IHNjaGVk
X2xpc3RbMF0gIT0gTlVMTCkpIHsKPj4+PiAJCWVudGl0eS0+c2NoZWRfbGlzdCA9IG51bV9zY2hl
ZF9saXN0ID4gMSA/IHNjaGVkX2xpc3QgOiBOVUxMOwo+Pj4+IAkJZW50aXR5LT5udW1fc2NoZWRf
bGlzdCA9IG51bV9zY2hlZF9saXN0Owo+Pj4+IAkJcmV0dXJuIDA7Cj4+Pj4gCX0gZWxzZSB7Cj4+
Pj4gCQlyZXR1cm4gLUVJTlZBTDsKPj4+PiAJfQo+Pj4+IH0KPj4+IEFjdHVhbGx5IHRoYXQncyBh
IHJhdGhlciBiYWQgaWRlYS4gRXJyb3IgaGFuZGxpbmcgc2hvdWxkIGFsd2F5cyBiZSBpbgo+PiBJ
IGFjdHVhbGx5IGRvbid0IHRoaW5rIHRoYXQgaXQgaXMgYSAicmF0aGVyIGJhZCBpZGVhIi4gQXQg
YWxsLgo+PiBJIGFjdHVhbGx5IHRoaW5rIHRoYXQgaXQgbWFrZXMgdGhpcyBsZWFmIGZ1bmN0aW9u
IG1vcmUgY2xlYXIgdG8KPj4gdW5kZXJzdGFuZCBhcyB0aGUgY29uZGl0aW9uYWwgd291bGQgcmVh
ZCBsaWtlIGEgc2VudGVuY2UgaW4gcHJvc2UuCj4gCj4gVGhlIGNvbmRpdGlvbiBpcyBpbmRlZWQg
ZWFzaWVyIHRvIHJlYWQsIGJ1dCBmb3IgdGhlIHNhY3JpZmljZSBvZiBlYXJsaWVyIAo+IHJldHVy
biBhbmQga2VlcGluZyBwcmVyZXF1aXNpdGUgY2hlY2tpbmcgb3V0IG9mIHRoZSBjb2RlLgoKWW91
IGtub3cgdGhlIGNvbXBpbGVyIGNhbiByZW9yZGVyIHN1Y2ggY29kZSBhbmQgaW52ZXJ0CnRoaXMg
c2ltcGxlLWZvci10aGUtY29tcGlsZXIgY29uZGl0aW9uYWwuIEl0IGlzIGVhc2llcgpmb3IgaHVt
YW4gcmVhZGVycyB3aG8gbWlnaHQgbmVlZCB0byBtYWludGFpbiBpdC4KCkZvciBpbnN0YW5jZSwg
d2hlbiB5b3UgYXNrZWQgIkRvIHlvdSBndXlzIHJlbWVtYmVyIHdoeSB3ZQptaWdodCBub3QgaGF2
ZSBhIGpvYiBoZXJlPyIgZm9yIGFtZGdwdV9pYl9zY2hlZHVsZSgpCmluIGEgcmVjZW50IGVtYWls
LS1pZiB0aGF0IGNvZGUgaGFkIGJlZW4gc3BsaXQgaW50byBjb2RlIGZvciAKdGVzdCBwdXJwb3Nl
cyBhbmQgcmVhbCBJQiBwcm9jZXNzaW5nIGNvZGUsIHRoZW4gdGhhdCBxdWVzdGlvbgp3b3VsZG4n
dCBldmVuIGJlIG9uIHRoZSB0YWJsZS4KCldlIG5lZWQgdG8gYWNoaWV2ZSBhIGJhbGFuY2Ugb2Yg
YnJlYWtpbmcgb3V0IGNvZGUgYW5kIGlmLWVsc2UKc3RhdGVtZW50cy4gQXQgdGhlIG1vbWVudCB0
aGUgY29kZSBzaG93IGV2ZXJ5dGhpbmcgYnVuY2hlZAp1cCBpbnRvIGEgc2luZ2xlIGZ1bmN0aW9u
IGFuZCBhIHRvbiBvZiBpZi1lbHNlIHN0YXRlbWVudHMsCndpdGggdGhlIHByZXRlbnNlICJ0byBh
dm9pZCBkdXBsaWNhdGlvbiIuIFN1Y2ggZHVwbGljYXRpb24gY2FuIGJlCmF2b2lkZWQgYXJjaGl0
ZWN0dXJhbGx5IGJ5IHJlZGVmaW5pbmcgc3RydWN0dXJlcywgd2hhdCdzIGluIHRoZW0sCmFuZCB3
aGF0IGFyZ3VtZW50cyBmdW5jdGlvbnMgdGFrZS4KCj4gCj4+IFtTTklQXQo+Pj4gV2hhdCB3ZSBz
aG91bGQgZG8gaW5zdGVhZCBpcyBqdXN0OiBXQVJOX09OKCFudW1fc2NoZWRfbGlzdCB8fCAhc2No
ZWRfbGlzdCk7Cj4+IEFnYWluLCB3aGF0IGRvZXMgdGhhdCAqbWVhbio/IFdoYXQgZG9lcyB0aGUg
Y2hlY2sgbWVhbiBhbmQgd2hhdAo+PiBkb2VzIHRoZSBudW1fc2NoZWRfbGlzdCA9PSAwIG9yIHNj
aGVkX2xpc3QgPT0gTlVMTCBtZWFuPwo+PiBBbmQgaG93IGRpZCB3ZSBnZXQgaW50byBhIHNpdHVh
dGlvbiBsaWtlIHRoaXMgd2hlcmUgZWl0aGVyIG9yIGJvdGgKPj4gY291bGQgYmUgbmlsPwo+IAo+
IEl0J3MgYW4gaW4ga2VybmVsIGNvZGluZyBlcnJvciB0byBkbyB0aGlzLiBUaGUgY2FsbGVyIHNo
b3VsZCBhdCBsZWFzdCAKPiBhbHdheXMgcHJvdmlkZSBhIGxpc3Qgd2l0aCBzb21lIGVudHJpZXMg
aW4gaXQuCj4gCj4gQSBXQVJOX09OKCkgaXMgYXBwcm9wcmlhdGUgc2luY2UgaXQgaGVscHMgdG8g
bmFycm93cyBkb3duIHRoZSBpbmNvcnJlY3QgCj4gYmVoYXZpb3IgZm9sbG93aW5nIGZyb20gdGhh
dC4KPiAKPj4gV291bGRuJ3QgaXQgYmUgYmV0dGVyIHRvIHNpbXBsaWZ5IG9yIHJlLWFyY2hpdGVj
dHVyZSB0aGlzICh3ZSBvbmx5IHJlY2VudGx5Cj4+IGRlY2lkZWQgdG8gaGlkZSBwaHlzaWNhbCBy
aW5ncyBmcm9tIHVzZXItc3BhY2UpLCBzbyB0aGF0IHRoZSBjb2RlCj4+IGlzIGVsZWdhbnQgKG1l
YW5pbmcgbm8gaWYtZWxzZSkgeWV0IGZsZXhpYmxlIGFuZCBzdHJhaWdodGZvcndhcmQ/Cj4gCj4g
VGhhdCB3YXMgbm90IHJlY2VudGx5IGF0IGFsbCwgaGlkaW5nIHBoeXNpY2FsIHJpbmdzIHdhcyBk
b25lIG5lYXJseSA1IAo+IHllYXJzIGFnbyBzaG9ydGx5IGFmdGVyIHRoZSBkcml2ZXIgd2FzIGlu
aXRpYWxseSByZWxlYXNlZC4KPiAKPj4+PiBXaHkgbm90IGZpeCB0aGUgYXJjaGl0ZWN0dXJlIHNv
IHRoYXQgdGhpcyBpcyBzaW1wbHkgY29waWVkPwo+Pj4gV2UgaGFkIHRoYXQgYW5kIG1vdmVkIGF3
YXkgZnJvbSBpdCBiZWNhdXNlIHRoZSBzY2hlZHVsZXIgbGlzdCBpcwo+Pj4gYWN0dWFsbHkgY29u
c3QgYW5kIHNob3VsZG4ndCBiZSBhbGxvY2F0ZWQgd2l0aCBlYWNoIGVudGl0eSAod2hpY2ggd2Ug
Y2FuCj4+PiBlYXNpbHkgaGF2ZSB0aG91c2FuZHMgb2YpLgo+PiBJIHRoaW5rIHRoYXQgcGVwcGVy
aW5nIHRoZSBjb2RlIHdpdGggaWYtZWxzZSBjb25kaXRpb25hbHMKPj4gZXZlcnl3aGVyZSBhcyB0
aGVzZSBwYXRjaC1zZXJpZXMgaW50byB0aGUgRFJNIHNjaGVkdWxlciBoYXZlIGJlZW4sCj4+IHdv
dWxkIG1ha2UgdGhlIGNvZGUgdW5tYWludGFpbmFibGUgaW4gdGhlIGxvbmcgcnVuLgo+IAo+IFRo
YXQncyBzb21ldGhpbmcgSSBjYW4gYWdyZWUgb24uIFVzaW5nIGEgc3dpdGNoIHRvIG1hcCB0aGUg
cHJpb3JpdHkgdG8gCj4gdGhlIGJhY2tlbmQgaW1wbGVtZW50YXRpb24gc2VlbXMgbGlrZSB0aGUg
YmVzdCBpZGVhIHRvIG1lLgoKRG8geW91IG1lYW4geW91IGRvbid0IGFncmVlIHdpdGggYW55dGhp
bmcgSSB3cml0ZT8gKElmIHlvdSBoYXZlCnRvIG1ha2UgYSBwb2ludCBvZiBpdCBoZXJlIHRoYXQg
KnRoYXQqIGlzIHNvbWV0aGluZyB5b3UgY2FuIGFncmVlIG9uPwoKSSdkIHNheSwgZXZlbiBhIGZ1
bmN0aW9uIGlzIHRvbyBoZWF2eS4gQSBzdHJhaWdodGZvcndhcmQgbWFwIHNob3VsZApiZSB1c2Vk
LCBubyBmdW5jdGlvbiBjYWxsLCBubyBzd2l0Y2ggKGlmLWVsc2UgaW4gZGlzZ3Vpc2UpLCBqdXN0
CmEgbWFwIGZvciBpbnN0YW50IGxvb2t1cC4KClJlZ2FyZHMsCkx1YmVuCgoKPiAKPiBFLmcuIGZ1
bmN0aW9uIGFtZGdwdV90b19zY2hlZF9wcmlvcml0eSgpIHNob3VsZCBub3Qgb25seSBtYXAgdGhl
IElPQ1RMIAo+IHZhbHVlcyB0byB0aGUgc2NoZWR1bGVyIHZhbHVlcywgYnV0IGFsc28gcmV0dXJu
IHRoZSBhcnJheSB3aGljaCBodyByaW5ncyAKPiB0byB1c2UuCj4gCj4gUmVnYXJkcywKPiBDaHJp
c3RpYW4uCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
