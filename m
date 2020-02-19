Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9303C34022
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 08:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D6E208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 08:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fmIBb+Q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D6E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C8A6EB27;
	Wed, 19 Feb 2020 08:24:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00A16EB27
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 08:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWWvMBCX7j1Qk0+Z85sBpL4hS22+X3EC6JmjJNotoaVIjmKjVcKJVbvp/2xNMu4yVGmDYRigTwHyOzFS07rqSPfTThhI+iUl8s7eaTvOnJx+GaYMZuew9ccEZCL18GemCiDG324cV6Ln2kO2ToK3EJcWPOztkb0yTrLOhaaS+5DEY+YpltnTU3D1bkSBVEbNDsI+Q4JSjr1HviUFvFQI/47yVFOuSF0YEDOvqeKN3jZfSjOApd8Gho8hoMOEZOiWzOYXBNR7+Ufwlg+iUGLw8l4r5piNTYo7qt6vd82szia/M90PkaK5Up9JFxzJaYcMCq8hLvXN0hgWAXJedDFZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HoztMD0Mz6epFgdUGlS1RywDXSm0fmywTV7VJnKVrA=;
 b=kicVu2lDWfEdWoIpttbUTDZZF8xoPZuDOHMj4LNW5b9Wp1Gpdl31vRW+8vYQ+p0U7y8I3ZnMnPmwuCysns0swbHz0cFtcZQ5Wiubl0VS0ScLsWg0wBgkTlJ51zSDc1Gici0B8whJyVPj5QHGC3lDYbfLAMj7WItAQ/xSGP4k5t3b50l90jE7shVILPGetik0gPA3rncy9X0CpT6Zt5mutHo+v17Xi82/4Qg6GO8rUAxq1rbwB5IKVeFbX8r2OJp2lYF+6RrojDUnHxNcfQEpfVOYVol5jWWQTJbAQT1vxMvDHYs8PNvE+RTzoBO9yNvFW5Xoh9MGY9LdKIJEM6O5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HoztMD0Mz6epFgdUGlS1RywDXSm0fmywTV7VJnKVrA=;
 b=fmIBb+Q2G3SnBWCQ/cUOcKqivXcSwsVLM7bZ+KJM92zeeJ5Lvy/b5UnRVC5MZ0j5ICIrNzomP3haW+iOiTnkk30Ag3TqRPzO6xhdLoqn/NlCIt2ch7/1xdtP/pSZHDLer9DiBr10N+LOaLXBZUZCd+7rIB3bJmj47kKbLRWaSbs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1708.namprd12.prod.outlook.com (10.175.89.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 08:24:17 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2729.032; Wed, 19 Feb
 2020 08:24:17 +0000
Subject: Re: [RFC PATCH v5] drm/amdgpu: Remove kfd eviction fence before
 release bo
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20200218033650.7665-1-xinhui.pan@amd.com>
 <76285bd7-70df-09be-2e05-a4b75bb3e879@amd.com>
 <DB6DDBF8-FFA0-457E-8D87-B55FDD9B9D75@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9c8e1245-3e76-ee1d-ad0b-6dbb630081d5@amd.com>
Date: Wed, 19 Feb 2020 09:24:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <DB6DDBF8-FFA0-457E-8D87-B55FDD9B9D75@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0084.eurprd02.prod.outlook.com
 (2603:10a6:208:154::25) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0084.eurprd02.prod.outlook.com (2603:10a6:208:154::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend
 Transport; Wed, 19 Feb 2020 08:24:16 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e29ed6f5-2d90-40a3-ea3e-08d7b5151c6d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1708:|DM5PR12MB1708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17089D764E3033642D3B91E583100@DM5PR12MB1708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(189003)(199004)(31696002)(6636002)(66574012)(36756003)(54906003)(110136005)(6666004)(6486002)(2906002)(81166006)(66476007)(478600001)(52116002)(186003)(66946007)(4326008)(53546011)(8936002)(8676002)(5660300002)(86362001)(316002)(66556008)(31686004)(16526019)(2616005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1708;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bhm7wSVHWjHd/WX9P7dd5F1eACIDs6moskBVPXUNdd8JlSdPx/HltdS+WVJKZxqfv4kSPpx4CtaVKlwwywZko1Uc39k4WhkX/9x2c7SNZ02Metm/z5cUBeW5LdzHIdlljk5Dcs+O6S00zYGvjVthWULhAYGuLXpLqmwJvaMQlbpBoZ791juF0rJcz6132petoIE841nonfSNhcXsnVhs6a71HA9HaZnpPN1ZMuRWPApDL+M8oN4CaqTfHuiynKtVnCPTgaukXW/DassXedY0KG61urPwGKgxr99xxtR1Ph0x5LCZa4bVKaMNfZ/VAKtXYtCE6fIUUiSC9npvdvbVk4S4vMeMjdfaiEkSDbK8YmXUD/rf6qfDk8hSUbsjmqC+Bngiy2KA03VrlicHjblM9ruKkfWin7pzQBXwb6tgs57rV3q08+93LPn9LbuLdeC4
X-MS-Exchange-AntiSpam-MessageData: Psg1Xsfz5uGOPcoqL/hK7xlGngErSJTTfVYXLZYM4XkBGWLXrpQbDd40pBjfxsbktR9VVTNIg6iJwZtgt/XfzZoQr7zWTTjPSwgWPWug9k/phBz4TQA/u3ZpjnGjpiiWrIb1137zIbCx4whXgVQkLzYaaNKHKrByisV7L5JafcfeT6NzaPTM2ldC417TuWEB8jpnAjByo5iwJ3KixFNqPA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29ed6f5-2d90-40a3-ea3e-08d7b5151c6d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:24:17.3819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usc1KQiA/MX1KjwUf9D5EGhSqKMPT1HIY9QbxUoJ/NNT5fXCsWj8SfDsPEtvs6rz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTkuMDIuMjAgdW0gMDI6NTQgc2NocmllYiBQYW4sIFhpbmh1aToKPgo+PiAyMDIw5bm0Muac
iDE55pelIDA3OjEw77yMS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPiDl
hpnpgZPvvJoKPj4KPj4gSGkgWGluaHVpLAo+Pgo+PiBUd28gc3VnZ2VzdGlvbnMgaW5saW5lLiBM
b29rcyBnb29kIHRvIG1lIG90aGVyd2lzZS4KPj4KPj4gT24gMjAyMC0wMi0xNyAxMDozNiBwLm0u
LCB4aW5odWkgcGFuIHdyb3RlOgo+Pj4gTm8gbmVlZCB0byB0cmlnZ2VyIGV2aWN0aW9uIGFzIHRo
ZSBtZW1vcnkgbWFwcGluZyB3aWxsIG5vdCBiZSB1c2VkCj4+PiBhbnltb3JlLgo+Pj4KPj4+IEFs
bCBwdC9wZCBib3Mgc2hhcmUgc2FtZSByZXN2LCBoZW5jZSB0aGUgc2FtZSBzaGFyZWQgZXZpY3Rp
b24gZmVuY2UuCj4+PiBFdmVyeXRpbWUgcGFnZSB0YWJsZSBpcyBmcmVlZCwgdGhlIGZlbmNlIHdp
bGwgYmUgc2lnbmxlZCBhbmQgdGhhdCBjdWFzZXMKPj4+IGtmZCB1bmV4Y2VwdGVkIGV2aWN0aW9u
cy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+
Cj4+PiBDQzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4g
Q0M6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29tPgo+Pj4gQ0M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gY2hhbmdlIGZy
b20gdjQ6Cj4+PiBiYXNlZCBvbiBuZXcgdHRtIGNvZGUuCj4+Pgo+Pj4gY2hhbmdlIGZyb20gdjM6
Cj4+PiBmaXggYSBjb2RpbmcgZXJyb3IKPj4+Cj4+PiBjaGFuZ2UgZnJvbSB2MjoKPj4+IGJhc2Vk
IG9uIENocmlzJyBkcm0vdHRtOiByZXdvcmsgQk8gZGVsYXllZCBkZWxldGUgcGF0Y2hzZXQuCj4+
Pgo+Pj4gLS0tCj4+PiAtLS0KPj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZC5oICAgIHwgIDEgKwo+Pj4gICAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ3B1dm0uYyAgfCAzNyArKysrKysrKysrKysrKysrKysrCj4+PiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyAgICB8ICA0ICsrCj4+PiAgIDMgZmlsZXMg
Y2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkLmgKPj4+IGluZGV4IDllOGRiNzAyZDg3OC4uMGVlOGFhZTZjNTE5
IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZC5oCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgK
Pj4+IEBAIC05Niw2ICs5Niw3IEBAIHN0cnVjdCBhbWRncHVfYW1ka2ZkX2ZlbmNlICphbWRncHVf
YW1ka2ZkX2ZlbmNlX2NyZWF0ZSh1NjQgY29udGV4dCwKPj4+ICAgCQkJCQkJICAgICAgIHN0cnVj
dCBtbV9zdHJ1Y3QgKm1tKTsKPj4+ICAgYm9vbCBhbWRrZmRfZmVuY2VfY2hlY2tfbW0oc3RydWN0
IGRtYV9mZW5jZSAqZiwgc3RydWN0IG1tX3N0cnVjdCAqbW0pOwo+Pj4gICBzdHJ1Y3QgYW1kZ3B1
X2FtZGtmZF9mZW5jZSAqdG9fYW1kZ3B1X2FtZGtmZF9mZW5jZShzdHJ1Y3QgZG1hX2ZlbmNlICpm
KTsKPj4+ICtpbnQgYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZmVuY2Vfb25fcHRfcGRfYm9zKHN0cnVj
dCBhbWRncHVfYm8gKmJvKTsKPj4+ICAgICBzdHJ1Y3QgYW1ka2ZkX3Byb2Nlc3NfaW5mbyB7Cj4+
PiAgIAkvKiBMaXN0IGhlYWQgb2YgYWxsIFZNcyB0aGF0IGJlbG9uZyB0byBhIEtGRCBwcm9jZXNz
ICovCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
cHV2bS5jCj4+PiBpbmRleCBlZjcyMWNiNjU4NjguLjZhYTIwYWE4MmJkMyAxMDA2NDQKPj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+Pj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+
PiBAQCAtMjc2LDYgKzI3Niw0MSBAQCBzdGF0aWMgaW50IGFtZGdwdV9hbWRrZmRfcmVtb3ZlX2V2
aWN0aW9uX2ZlbmNlKHN0cnVjdCBhbWRncHVfYm8gKmJvLAo+Pj4gICAJcmV0dXJuIDA7Cj4+PiAg
IH0KPj4+ICAgK2ludCBhbWRncHVfYW1ka2ZkX3JlbW92ZV9mZW5jZV9vbl9wdF9wZF9ib3Moc3Ry
dWN0IGFtZGdwdV9ibyAqYm8pCj4+PiArewo+Pj4gKwlzdHJ1Y3QgYW1kZ3B1X2JvICpyb290ID0g
Ym87Cj4+PiArCXN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSAqdm1fYm87Cj4+PiArCXN0cnVjdCBh
bWRncHVfdm0gKnZtOwo+Pj4gKwlzdHJ1Y3QgYW1ka2ZkX3Byb2Nlc3NfaW5mbyAqaW5mbzsKPj4+
ICsJc3RydWN0IGFtZGdwdV9hbWRrZmRfZmVuY2UgKmVmOwo+Pj4gKwlpbnQgcmV0Owo+Pj4gKwo+
Pj4gKwl3aGlsZSAocm9vdC0+cGFyZW50KQo+Pj4gKwkJcm9vdCA9IHJvb3QtPnBhcmVudDsKPj4g
VGhpcyBzaG91bGQgbm90IGJlIG5lY2Vzc2FyeS4gRXZlcnkgcGFnZSB0YWJsZSBCTyBoYXMgYSBw
b2ludGVyIHRvIGEgdm1fYm8gdGhhdCBoYXMgYSBwb2ludGVyIHRvIHRoZSB2bS4gU28geW91IGRv
bid0IG5lZWQgdG8gZmluZCB0aGUgcm9vdC4KPj4KPj4gVGhpcyBzaG91bGQgZG8gdGhlIHRyaWNr
Ogo+Pgo+PiAJaWYgKCFiby0+dm1fYm8gfHwgIWJvLT52bV9iby0+dm0pCj4+IAkJcmV0dXJuIDA7
Cj4+IAl2bSA9IGJvLT52bV9iby0+dm07Cj4+Cj4+Cj4gd2VsbCx3aGVuIGZyZWUgcGFnZSB0YWJs
ZXMsIGl0IGNsZWFycyBiby0+dm1fYm8gZmlyc3QgdGhlbiByZWxlYXNlIHB0L3BkIGJvLgo+IEFs
c28gd2UgY2FuIGNoYW5nZSB0aGUgc2VxdWVuY2UgbGlrZSBJIGRvIGluIFYyLCBsb29rcyBsaWtl
IGhpdCBzb21lIHdlaXJkIGlzc3Vlcy4KPgo+Pj4gKwo+Pj4gKwl2bV9ibyA9IHJvb3QtPnZtX2Jv
Owo+Pj4gKwlpZiAoIXZtX2JvKQo+Pj4gKwkJcmV0dXJuIDA7Cj4+PiArCj4+PiArCXZtID0gdm1f
Ym8tPnZtOwo+Pj4gKwlpZiAoIXZtKQo+Pj4gKwkJcmV0dXJuIDA7Cj4+PiArCj4+PiArCWluZm8g
PSB2bS0+cHJvY2Vzc19pbmZvOwo+Pj4gKwlpZiAoIWluZm8gfHwgIWluZm8tPmV2aWN0aW9uX2Zl
bmNlKQo+Pj4gKwkJcmV0dXJuIDA7Cj4+PiArCj4+PiArCWVmID0gY29udGFpbmVyX29mKGRtYV9m
ZW5jZV9nZXQoJmluZm8tPmV2aWN0aW9uX2ZlbmNlLT5iYXNlKSwKPj4+ICsJCQlzdHJ1Y3QgYW1k
Z3B1X2FtZGtmZF9mZW5jZSwgYmFzZSk7Cj4+PiArCj4+PiArCWRtYV9yZXN2X2xvY2soYm8tPnRi
by5iYXNlLnJlc3YsIE5VTEwpOwoKTm93IHRoYXQgRmVsaXggbWVudGlvbmVkIGl0IHRoaXMgc2hv
dWxkIGJlIGEgZG1hX3Jlc3ZfdHJ5bG9jaygpLgoKZG1hX3Jlc3ZfbG9jaygpIGNhbiBpbnRlbnRp
b25hbGx5IGZhaWwgcmFuZG9tbHkgZm9yIHRlc3RpbmcgcHVycG9zZXMsIApidXQgdHJ5bG9jaygp
IHdpbGwgYWx3YXlzIHN1Y2NlZWQgYmVjYXVzZSB3ZSBhcmUgdGhlIG9ubHkgb25lIApyZWZlcmVu
Y2luZyB0aGUgQk8gYXQgdGhlIG1vbWVudC4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4+PiArCXJl
dCA9IGFtZGdwdV9hbWRrZmRfcmVtb3ZlX2V2aWN0aW9uX2ZlbmNlKGJvLCBlZik7Cj4+PiArCWRt
YV9yZXN2X3VubG9jayhiby0+dGJvLmJhc2UucmVzdik7Cj4+PiArCj4+PiArCWRtYV9mZW5jZV9w
dXQoJmVmLT5iYXNlKTsKPj4+ICsJcmV0dXJuIHJldDsKPj4+ICt9Cj4+PiArCj4+PiAgIHN0YXRp
YyBpbnQgYW1kZ3B1X2FtZGtmZF9ib192YWxpZGF0ZShzdHJ1Y3QgYW1kZ3B1X2JvICpibywgdWlu
dDMyX3QgZG9tYWluLAo+Pj4gICAJCQkJICAgICBib29sIHdhaXQpCj4+PiAgIHsKPj4+IEBAIC0x
MDQ1LDYgKzEwODAsOCBAQCB2b2lkIGFtZGdwdV9hbWRrZmRfZ3B1dm1fZGVzdHJveV9jYihzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+ICAgCWxpc3RfZGVsKCZ2bS0+dm1fbGlzdF9ub2Rl
KTsKPj4+ICAgCW11dGV4X3VubG9jaygmcHJvY2Vzc19pbmZvLT5sb2NrKTsKPj4+ICAgKwl2bS0+
cHJvY2Vzc19pbmZvID0gTlVMTDsKPj4+ICsKPj4+ICAgCS8qIFJlbGVhc2UgcGVyLXByb2Nlc3Mg
cmVzb3VyY2VzIHdoZW4gbGFzdCBjb21wdXRlIFZNIGlzIGRlc3Ryb3llZCAqLwo+Pj4gICAJaWYg
KCFwcm9jZXNzX2luZm8tPm5fdm1zKSB7Cj4+PiAgIAkJV0FSTl9PTighbGlzdF9lbXB0eSgmcHJv
Y2Vzc19pbmZvLT5rZmRfYm9fbGlzdCkpOwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9vYmplY3QuYwo+Pj4gaW5kZXggNmY2MGE1ODFlM2JhLi4xNjU4NjY1MTAyMGYgMTAw
NjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMK
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+Pj4g
QEAgLTEzMDcsNiArMTMwNywxMCBAQCB2b2lkIGFtZGdwdV9ib19yZWxlYXNlX25vdGlmeShzdHJ1
Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvKQo+Pj4gICAJaWYgKGFiby0+a2ZkX2JvKQo+Pj4gICAJ
CWFtZGdwdV9hbWRrZmRfdW5yZXNlcnZlX21lbW9yeV9saW1pdChhYm8pOwo+Pj4gICArCS8qIFdl
IG9ubHkgcmVtb3ZlIHRoZSBmZW5jZSBpZiB0aGUgcmVzdiBoYXMgaW5kaXZpZHVhbGl6ZWQuICov
Cj4+PiArCWlmIChiby0+YmFzZS5yZXN2ID09ICZiby0+YmFzZS5fcmVzdikKPj4gU2hvdWxkIHRo
aXMgYmUgYSBXQVJOX09OPyBXZSBleHBlY3QgdGhpcyBjb25kaXRpb24gdG8gYmUgYWx3YXlzIHRy
dWUuIElmIGl0J3Mgbm90LCB0aGVyZSBzaG91bGQgYmUgYSBub2lzeSB3YXJuaW5nIHRoYXQgc29t
ZXRoaW5nIGlzIHdyb25nLgo+IGdvb2QgcG9pbnQuCj4KPiB0aGFua3MKPiB4aW5odWkKPgo+PiBS
ZWdhcmRzLAo+PiAgICBGZWxpeAo+Pgo+Pgo+Pj4gKwkJYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZmVu
Y2Vfb25fcHRfcGRfYm9zKGFibyk7Cj4+PiArCj4+PiAgIAlpZiAoYm8tPm1lbS5tZW1fdHlwZSAh
PSBUVE1fUExfVlJBTSB8fCAhYm8tPm1lbS5tbV9ub2RlIHx8Cj4+PiAgIAkgICAgIShhYm8tPmZs
YWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9XSVBFX09OX1JFTEVBU0UpKQo+Pj4gICAJCXJl
dHVybjsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
