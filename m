Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6160BC0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 09:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E165320658
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 09:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eha+2+Oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E165320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9617B6E3AC;
	Mon, 16 Mar 2020 09:38:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E296E3AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 09:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6Dp0/Z/PZWvea3UWwN7NJOz4iqHjoIGyH3PPZr6kYUCyc1IV5nRsLMhSDQXhwFkdEiCOI+cGSzMnLRZYGg4BUutv8QJ071Wo9Qs9bPesvjpH9je6zTwrwNR06xKEsZOc8YnaPZ94oZ/qhheMXWH0LYyXZCHYb3k7NpObDyLgimgF4f6FUDZLjvlgtqfIkjrmrmJXpXxAl4TR4BSjnMci76AFs5JPQiHcKBBiZM/WjSV8SPfr5q1IpbxtgEhTqYOm9HmFMiaq1AYWGJlIw4Cz3Q6upFoPMkSt0gJvM+v4f1HyAOQ3n6etadNSCTZDfPCUnNMry1HvmI+UkJPSpxOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDy+RB9HL84CzMdCgjmFb5Yyi5Cjp7GBTV1MELjRuj4=;
 b=FzCcsTRZlY2OQaDj67QI4Hj3wx6GyXrFHlqWEW8IX3zbsCzWLEAv0/rPJXe5TCtqlhkiePjg7bH+3AxV2T+1+FMSXFjFukGNq2ut04weWXCrLGNwUSosb+56VucK2HHybTus4a/3IUs1s0KTkahDzbpby6u5MF2igWWvd2lyui4/eo/MoTpi6h5v+APl5RLesc2El64vkArxu0VbHOhXtv6jD0AhWUBdB+Fdh4wuMkW42j7L8L6MldljNZ7y0//F8twOiBvuOuEPiAvlPtZj+2w27CdlPTNTsQTpDZAVLse0w5dvbckx/23mEAow9hoNPWpxKGSRJaG3Biua1jkmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDy+RB9HL84CzMdCgjmFb5Yyi5Cjp7GBTV1MELjRuj4=;
 b=eha+2+OcejzqZG7Acedqc++yYfDzwi6teTSkovxGG4p6NRkYGtoA7wfNFCRdhi7ajMTEVlAgxhwNhgp9NByg6lY3aFGiPFfv9rFbXEd4X8r8RMbzE9I202Gl7UIxFek23Ro7w9CW6Ry+6vRa9w9oX8DH2V3wLNqiHZgaIL5vBF0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1593.namprd12.prod.outlook.com (2603:10b6:4:10::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Mon, 16 Mar 2020 09:38:29 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f%11]) with mapi id 15.20.2814.021; Mon, 16 Mar
 2020 09:38:29 +0000
Subject: Re: [PATCH] drm/amdgpu: miss PRT case when bo update
To: Yintian Tao <yttao@amd.com>, Alexander.Deucher@amd.com
References: <20200316075252.29897-1-yttao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <920f9784-1259-bad9-502c-885f7da4748b@amd.com>
Date: Mon, 16 Mar 2020 10:38:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200316075252.29897-1-yttao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::38) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0025.eurprd01.prod.exchangelabs.com (2603:10a6:208:69::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend
 Transport; Mon, 16 Mar 2020 09:38:28 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18be862f-6e2b-4856-e9e2-08d7c98dc8a1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1593:|DM5PR12MB1593:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB159378733EE7D95C94CD0FAD83F90@DM5PR12MB1593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(2616005)(5660300002)(4326008)(31686004)(2906002)(52116002)(186003)(16526019)(6636002)(316002)(36756003)(66574012)(6666004)(478600001)(15650500001)(8936002)(31696002)(81166006)(66476007)(81156014)(8676002)(86362001)(66946007)(6486002)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1593;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+w6C3RkZq5A37XR5G29AU/SJG7hSijjqyP8AxBr8dpP7NKO7jooYKKoFqOFubliyb1Mo/kgGJk9cRa/UOgQ5UuIfG5bAQ7Dd/EZkVYjvQdu4TW+8MIiVdD79STYLfLr3u2Q6P+NFyQDpv1rngmne/6uuxYYvLGjvuM1QWCSGwGrDhKqGgGHjvRRD33k3+dToZhzpGMgQXcVP0wKyDSBJop+o3UEA9WoofslI897wO9E+pEQmyzcmRyCNJutKmtNaE7D71qEnkLCYRBlKt8U3bn2p8sjBzZodiFdNdr4ddh9qNxpr/s6HU7wNCeMm/qUJ+WyG1XIPfLYQp1LQuA6y3pHQjUiSkfFWGHZ7ueaynVQfLzH1fJmY93Jr9Bl37rv4txX9suhlRN5So0Go9yOIv5yZwe4DpazAC57Y2i74PBvHEZvmvlT8RMMZpCbjj1J
X-MS-Exchange-AntiSpam-MessageData: CLqMWU7h3xeq8Y11jCbWbZj3BM4dTbPC9oqUUMbySB7y53CkQ/XwggJIdvn7sf+4ICGTYMTc1pOKLnK7iTDQdy2FVLb8sToyhv7WJR7iHqU8a4mVAL1bep0ITAsJOigyWh1BWXUvE8DAAGCIi+4QUnUhgDhh7OL2rioV2YaOkv6DTX1wTi1WuLwAI8pCIu442NYbvYvq7S1qrQmoW1pNUw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18be862f-6e2b-4856-e9e2-08d7c98dc8a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 09:38:29.2999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rzlHrSBg/tl+b5axPs+3sKQhTpYKoPMYQWBU/tzfpjrcI03TLS/tTV9r8Nd4BbB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1593
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTYuMDMuMjAgdW0gMDg6NTIgc2NocmllYiBZaW50aWFuIFRhbzoKPiBPcmlnaW5hbGx5LCBv
bmx5IHRoZSBQVEUgdmFsaWQgaXMgdGFrZW4gaW4gY29uc2lkZXIuCj4gVGhlIFBSVCBjYXNlIGlz
IG1pc3NpZWQgd2hlbiBibyB1cGRhdGUgd2hpY2ggcmFpc2UgcHJvYmxlbS4KPiBXZSBuZWVkIGFk
ZCBjb25kaXRpb24gZm9yIFBSVCBjYXNlLgoKR29vZCBjYXRjaCwganVzdCBvbmUgc3R5bGUgbml0
IHBpY2sgYmVsb3cuCgo+Cj4gU2lnbmVkLW9mZi1ieTogWWludGlhbiBUYW8gPHl0dGFvQGFtZC5j
b20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDUg
KystLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IGluZGV4IDczMzk4ODMx
MTk2Zi4uN2EzZTQ1MTRhMDBjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMKPiBAQCAtMTQ0Niw3ICsxNDQ2LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBkYXRl
X3B0ZXMoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsCj4gICAJCXVpbnQ2
NF90IGluY3IsIGVudHJ5X2VuZCwgcGVfc3RhcnQ7Cj4gICAJCXN0cnVjdCBhbWRncHVfYm8gKnB0
Owo+ICAgCj4gLQkJaWYgKGZsYWdzICYgQU1ER1BVX1BURV9WQUxJRCkgewo+ICsJCWlmIChmbGFn
cyAmIChBTURHUFVfUFRFX1ZBTElEIHwgQU1ER1BVX1BURV9QUlQpKSB7Cj4gICAJCQkvKiBtYWtl
IHN1cmUgdGhhdCB0aGUgcGFnZSB0YWJsZXMgY292ZXJpbmcgdGhlCj4gICAJCQkgKiBhZGRyZXNz
IHJhbmdlIGFyZSBhY3R1YWxseSBhbGxvY2F0ZWQKPiAgIAkJCSAqLwo+IEBAIC0xNjA1LDcgKzE2
MDUsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKPiAgIAo+ICAgCWlmIChmbGFncyAmIEFNREdQVV9QVEVfVkFMSUQp
IHsKPiAgIAkJc3RydWN0IGFtZGdwdV9ibyAqcm9vdCA9IHZtLT5yb290LmJhc2UuYm87Cj4gLQo+
ICAgCQlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+bGFzdF9kaXJlY3QpKQoKUGxlYXNl
IGtlZXAgdGhpcyBlbXB0eSBsaW5lLCBpdCBpcyByZXF1aXJlZCBieSB0aGUgY29kaW5nIHN0eWxl
IGd1aWRlcy4KCldpdGggdGhhdCBmaXhlZCB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlz
dGlhbiBLw7ZuaWcgCjxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LgoKUmVnYXJkcywKQ2hyaXN0
aWFuLgoKPiAgIAkJCWFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9kaXJlY3QsIHRydWUp
Owo+ICAgCj4gQEAgLTE3MTgsNyArMTcxNyw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3Nw
bGl0X21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCQkJCUFNREdQVV9H
UFVfUEFHRVNfSU5fQ1BVX1BBR0U7Cj4gICAJCQl9Cj4gICAKPiAtCQl9IGVsc2UgaWYgKGZsYWdz
ICYgQU1ER1BVX1BURV9WQUxJRCkgewo+ICsJCX0gZWxzZSBpZiAoZmxhZ3MgJiAoQU1ER1BVX1BU
RV9WQUxJRCB8IEFNREdQVV9QVEVfUFJUKSkgewo+ICAgCQkJYWRkciArPSBib19hZGV2LT52bV9t
YW5hZ2VyLnZyYW1fYmFzZV9vZmZzZXQ7Cj4gICAJCQlhZGRyICs9IHBmbiA8PCBQQUdFX1NISUZU
Owo+ICAgCQl9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
