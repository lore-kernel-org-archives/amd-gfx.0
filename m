Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7E8C3F2CF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 07:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A056246A2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 07:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kkm0c9W1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A056246A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 326326EE11;
	Fri, 28 Feb 2020 07:47:20 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750080.outbound.protection.outlook.com [40.107.75.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D68786EE10
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 07:47:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPSd1oOroBOiq1FVOyONqtXXQrR7ZoQPzqOAThzrN93iYCVXdwRaRzvKZnHS3JSDz1EfmAURRUmPpGqxRp/BCz0QFCZDqTsuZnpLEASuXqJK8VhC8qpPyxasr0iN+DgdNPgWsAQDYQjxR2Q8QnXuhu4aJDgFAa8kzrPINENQP6ynxg9rtixehUOhEqMWQRsDQoONJSq6+K5JRPHjNz8PGGbIe5TfsS7x/8AmFEhPOu30Y4mg0ajeiCrbxHuLw5br3TOnHDN7cKWzSrLk09ErG5Libt8gWsZJ8YvKcoEkpLsVNWkD+MhpPpWtM1kgR7wTYMfiDCI+2Ct/2nwGhuukLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hjxKW/3RMwEjtfQT/jYz4Dz/kQvreObgt5IOObreDw=;
 b=F0GtalAi3n6PFfSSkqPGuASMUKiJeRdtR+jZ/LBjYGUL1lKuOmlTrQeKaJWCcb8/FZoVFVqS9Tk0/j5IC+0b5YTsKZDGoQM4XloZqejZEfEbWHdOQYz9HrzPhAbDFpqY8le1nd8apU0bJE93GQ+U8xFeqF4Cxa99lvza4LWB7vM0T2QFYBzX+Hhr3/KOfqOEmfDdsMAszLCDlDP+aTXC3W/NY7HzKT0Ylwk0YNbLxevTvyDrSnmMaOv1O0+0SoYg4s+mwFjKaCrmA1KtaplxsWVAS+dI5RRzJogqaLw3in9Eui88GJvTr6ms8Y/LSOhpoV/hxPQxhFn75JSPIk0rrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hjxKW/3RMwEjtfQT/jYz4Dz/kQvreObgt5IOObreDw=;
 b=kkm0c9W1HJjVt6/cRFByriss8nKovrYGvKcJa+doP26xDLaYD5s5jPKBdLyPGPLbDcL82kVs+5MPCOuWelWl0iw6Fn01iWHIe6pHR3hrRixqf05+vGYJRBhKcVVFgjPCU5P9t3YZeqPZUM5DhMVCG1SBHmooNZwAYdpCWc0r75A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Fri, 28 Feb
 2020 07:47:17 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2772.012; Fri, 28 Feb
 2020 07:47:17 +0000
Subject: Re: [RFC PATCH 2/4] drm/scheduler: implement a function to modify
 sched list
To: Luben Tuikov <luben.tuikov@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>, 
 amd-gfx@lists.freedesktop.org
References: <20200227214012.3383-1-nirmoy.das@amd.com>
 <20200227214012.3383-2-nirmoy.das@amd.com>
 <46106fdd-55ed-cb09-902e-a1c0cffd7b0d@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d87c9952-1eb8-5295-a1bc-475f5e94fc78@amd.com>
Date: Fri, 28 Feb 2020 08:47:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <46106fdd-55ed-cb09-902e-a1c0cffd7b0d@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:e6::18) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0041.eurprd01.prod.exchangelabs.com (2603:10a6:208:e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Fri, 28 Feb 2020 07:47:15 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32b3a39b-edfc-460b-2d43-08d7bc226e98
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:|DM5PR12MB2486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24866A780256C32CDDD8F79183E80@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(189003)(199004)(5660300002)(316002)(8936002)(52116002)(31686004)(6666004)(66476007)(66946007)(66556008)(86362001)(53546011)(31696002)(2906002)(4326008)(36756003)(110136005)(8676002)(81166006)(81156014)(6486002)(16526019)(186003)(478600001)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2486;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQ8u6kgDjyyXWRcwfph3vL3powas68lbLh3y1iioV4MIkEqhcoxT3WzTeqHyWLggs+ctJxoyJDMGg5S6DFG2FHtrVZDLfHd57nU4ag6jAxsrBarVL0Zrk3u3ScIiN4Yt0gVcSNqzA7yUWBZ3j04Xu9Pp+c+eL1N9RfzSdlDb365SCyYvLQtdDy+bJ4u83onWaaD+toIut/ywpZhXZSSo4lRAaC6n6VBSA8cSfdNtNsQ/QURI+Bo308Z9U1IXBIeoqyn/rRibdhBh43BQK2NrAmobRYAK39L/LWysMBAKsWjZNl3S7vnSoCP3pkiPj5xouPyr/VX7Z/RuhwzsJAQHBWaD6OuYsHsGAd+/x6ORUKOz46bthpxKba9hG4o3jiqq7AwkxYqzOvv/r3gjwr2lwkZBHwuR2bJRD9wfg3SZCcq7LrGFgZOPNPpxbmW1Jn4B
X-MS-Exchange-AntiSpam-MessageData: FhtQbF9M0K5/u9WIKSDjdHd1C4eA5m1vJWkfq/GZVPFjw5a0PMPMFnBRGfOYXHGI0mvsFoDhRCjsF12faCSY51gMMug4qtcQtAJHpW9bx1VKEoJh+GKTceDulKcn3gMrZMLUDssZlRM33j8ErhZXLhOJad+7igXFbp9xVGeLOdqw5lShV6ngcXB3csbQIv8vwTizSE7aFQ5VYBLBvIMEpA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b3a39b-edfc-460b-2d43-08d7bc226e98
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 07:47:16.8770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6yWQIW3PO+B0uGW1QWXXA0qJZ1Q5XdoIU5+sLiM/0qN8No4v1L3jsoXr6VrCmSR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjguMDIuMjAgdW0gMDY6MDggc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4gT24gMjAyMC0wMi0y
NyA0OjQwIHAubS4sIE5pcm1veSBEYXMgd3JvdGU6Cj4+IGltcGxlbWVudCBkcm1fc2NoZWRfZW50
aXR5X21vZGlmeV9zY2hlZCgpIHdoaWNoIGNhbiBtb2RpZnkgZXhpc3RpbmcKPj4gc2NoZWRfbGlz
dCB3aXRoIGEgZGlmZmVyZW50IG9uZS4gVGhpcyBpcyBnb2luZyB0byBiZSBoZWxwZnVsIHdoZW4K
Pj4gdXNlcnNwYWNlIGNoYW5nZXMgcHJpb3JpdHkgb2YgYSBjdHgvZW50aXR5IHRoZW4gZHJpdmVy
IGNhbiBzd2l0Y2ggdG8KPj4gY29ycmVzcG9uZGluZyBodyBzaGNlZCBsaXN0IGZvciB0aGF0IHBy
aW9yaXR5Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNv
bT4KPj4gLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8
IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKwo+PiAgIGluY2x1ZGUvZHJtL2dwdV9zY2hlZHVs
ZXIuaCAgICAgICAgICAgICAgfCAgNCArKysrCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNl
cnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX2VudGl0eS5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+
PiBpbmRleCA2M2JjY2QyMDFiOTcuLjcxMWU5ZDUwNGJjYiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+IEBAIC04Myw2ICs4MywzMCBAQCBpbnQgZHJt
X3NjaGVkX2VudGl0eV9pbml0KHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHksCj4+ICAg
fQo+PiAgIEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX2VudGl0eV9pbml0KTsKPj4gICAKPj4gKy8q
Kgo+PiArICogZHJtX3NjaGVkX2VudGl0eV9tb2RpZnlfc2NoZWQgLSBNb2RpZnkgc2NoZWQgb2Yg
YW4gZW50aXR5Cj4+ICsgKgo+PiArICogQGVudGl0eTogc2NoZWR1bGVyIGVudGl0eSB0byBpbml0
Cj4+ICsgKiBAc2NoZWRfbGlzdDogdGhlIGxpc3Qgb2YgbmV3IGRybSBzY2hlZHMgd2hpY2ggd2ls
bCByZXBsYWNlCj4+ICsgKgkJZXhpc3RpbmcgZW50aXR5LT5zY2hlZF9saXN0Cj4+ICsgKiBAbnVt
X3NjaGVkX2xpc3Q6IG51bWJlciBvZiBkcm0gc2NoZWQgaW4gc2NoZWRfbGlzdAo+PiArICoKPj4g
KyAqIFJldHVybnMgMCBvbiBzdWNjZXNzIG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvbiBmYWls
dXJlLgo+PiArICovCj4+ICtpbnQgZHJtX3NjaGVkX2VudGl0eV9tb2RpZnlfc2NoZWQoc3RydWN0
IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSwKPj4gKwkJCQkgIHN0cnVjdCBkcm1fZ3B1X3NjaGVk
dWxlciAqKnNjaGVkX2xpc3QsCj4+ICsJCQkJICB1bnNpZ25lZCBpbnQgbnVtX3NjaGVkX2xpc3Qp
Cj4+ICt7Cj4+ICsJaWYgKCEoZW50aXR5ICYmIHNjaGVkX2xpc3QgJiYgKG51bV9zY2hlZF9saXN0
ID09IDAgfHwgc2NoZWRfbGlzdFswXSkpKQo+PiArCQlyZXR1cm4gLUVJTlZBTDsKPiBUaGlzIHNl
ZW1zIHVubWFpbnRhaW5hYmxlLiBJJ2Qgd3JpdGUgaXQgaW4gaXRzIG5hdHVyYWwgZm9ybToKClRo
aXMgaXMgcHJvYmFibHkganVzdCBjb3B5ICYgcGFzdGVkIGZyb20gdGhlIGluaXQgZnVuY3Rpb24g
YW5kIGNvbXBsZXRlIApvdmVya2lsbCBoZXJlLgoKPgo+IGludCBkcm1fc2NoZWRfZW50aXR5X21v
ZGlmeV9zY2hlZChzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAo+IAkJCQkgIHN0cnVj
dCBkcm1fZ3B1X3NjaGVkdWxlciAqKnNjaGVkX2xpc3QsCj4gCQkJCSAgdW5zaWduZWQgaW50IG51
bV9zY2hlZF9saXN0KQo+IHsKPiAJaWYgKGVudGl0eSAmJiBzY2hlZF9saXN0ICYmIChudW1fc2No
ZWRfbGlzdCA9PSAwIHx8IHNjaGVkX2xpc3RbMF0gIT0gTlVMTCkpIHsKPiAJCWVudGl0eS0+c2No
ZWRfbGlzdCA9IG51bV9zY2hlZF9saXN0ID4gMSA/IHNjaGVkX2xpc3QgOiBOVUxMOwo+IAkJZW50
aXR5LT5udW1fc2NoZWRfbGlzdCA9IG51bV9zY2hlZF9saXN0Owo+IAkJcmV0dXJuIDA7Cj4gCX0g
ZWxzZSB7Cj4gCQlyZXR1cm4gLUVJTlZBTDsKPiAJfQo+IH0KCkFjdHVhbGx5IHRoYXQncyBhIHJh
dGhlciBiYWQgaWRlYS4gRXJyb3IgaGFuZGxpbmcgc2hvdWxkIGFsd2F5cyBiZSBpbiAKdGhlIGZv
cm0gb2Y6CgppZiAoY2hlY2tfZXJyb3IgfHwgbWlzc2luZ19wcmVyZXF1aXNpdGUpCiDCoMKgwqAg
cmV0dXJuX29yX2dvdG9fY2xlYW51cDsKCj4gVGhhdCdzIHRvbyBoZWF2eS4gQ2FuIHdlIGltcHJv
dmUgdGhlIGFyY2hpdGVjdHVyZQo+IHNvIHdlIGRvbid0IGhhdmUgdG8gY2hlY2sgZm9yIHRoaXMg
aW4gbGVhZiBmdW5jdGlvbnMgbGlrZSB0aGlzIG9uZT8KPiBXZSBjYW4ganVzdCByZXR1cm4gYSBw
YXJhbWV0ZXJpemF0aW9uLgo+Cj4gV2h5IHdvdWxkIHRoaXMgYmUgY2FsbGVkIHdpdGggZW50aXR5
IGJlaW5nIE5VTEw/Cj4gT3Igd2l0aCBzY2hlZF9saXN0IGJlaW5nIE5VTEw/IE9yIG51bV9zY2hl
ZF9saXN0IGJlaW5nIG5vdCB6ZXJvCj4geWV0IHNjaGVkX2xpc3RbMF0gYmVpbmcgTlVMTD8gV2h5
IG5vdCBtYWtlIHN1cmUgdGhhdCBzY2hlZF9saXN0WzBdIGlzCj4gbmV2ZXIgTlVMTCBhbmQgdGhh
dCBudW1fc2NoZWRfbGlzdCBpcyBncmVhdGVyIHRoYW4gMCBhbHdheXM/Cj4KPiBEb2VzIHRoaXMg
bWFrZSBpdCB0byB1c2VyIHNwYWNlPwo+IFdoeSB3b3VsZCB0aGUgc3RhdGUgb2YgZXhlY3V0aW9u
IGJlIG9uZSBzdWNoIHRoYXQgdGhpcyBpcyB0cnVlL2ZhbHNlCj4gZm9yIHRoZSBjb2RlIHRvIHJl
dHVybiAtRUlOVkFMPwo+ICBGcm9tIHBhdGNoIDMvNCBpdCBzZWVtcyB0aGF0IGFuIGVycm9yIGlz
IHByaW50ZWQgaW5zaWRlIGFtZGdwdV9jdHhfcHJpb3JpdHlfb3ZlcnJpZGUoKQo+IGFuZCB0aGUg
cmVzdWx0IGlzIG5vdCBwcm9wYWdhdGVkIHVwIHRoZSBzdGFjay4KPgo+IEkgdGhpbmsgd2Ugc2hv
dWxkIGltcHJvdmUgdGhlIGNvZGUgd2hlcmUgaGVyZSB0aGlzIGNvbmRpdGlvbiBhYm92ZQo+IGlz
IG5ldmVyIHRydWUuIFRoZW4gd2UgY2FuIHVzZSBwYXJhbWV0ZXJpemF0aW9uIGZvciB0aG9zZSB0
d28KPiBzdGF0ZW1lbnRzIGJlbG93Ogo+Cj4+ICsKPj4gKwllbnRpdHktPnNjaGVkX2xpc3QgPSBu
dW1fc2NoZWRfbGlzdCA+IDEgPyBzY2hlZF9saXN0IDogTlVMTDsKPiBTbyBpZiB3ZSdyZSBoZXJl
LCB3ZSBrbm93IGZyb20gdGhlIHRvcCBjb25kaXRpb25hbCB0aGF0Cj4gZWl0aGVyIG51bV9zY2hl
ZF9saXN0IGlzIDAgb3IgdGhhdCBzY2hlZF9saXN0WzBdIG5vdCBOVUxMCj4gb3IgYm90aC4KPgo+
IFNvIGlmIG51bV9zY2hlZF9saXN0IGlzIDAgb3IgMSB3ZSByZXR1cm4gTlVMTD8KPiBBbmQgaWYg
bnVtX3NjaGVkX2xpc3QgaXMgMiBvciBncmVhdGVyIHdlIHJldHVybiBzY2hlZF9saXN0Cj4gb2Yg
d2hpY2ggc2NoZWRfbGlzdFswXSBjb3VsZCBiZSBOVUxMPwoKVGhpcyBpcyBhbHNvIGNvcHkmcGFz
dGVkIGZyb20gdGhlIGluaXQgY29kZSBhbmQgY29tcGxldGVseSB3cm9uZyBoZXJlLgoKV2hhdCB3
ZSBzaG91bGQgZG8gaW5zdGVhZCBpcyBqdXN0OiBXQVJOX09OKCFudW1fc2NoZWRfbGlzdCB8fCAh
c2NoZWRfbGlzdCk7CgpBbmQgdG8gdGhlIGNoZWNraW5nIGZvciBub3Qga2VlcGluZyBhcm91bmQg
dGhlIHNjaGVkdWxlciBsaXN0IGluIHRoZSAKaW5pdCBmdW5jdGlvbi4KCj4gV2h5IG5vdCBmaXgg
dGhlIGFyY2hpdGVjdHVyZSBzbyB0aGF0IHRoaXMgaXMgc2ltcGx5IGNvcGllZD8KCldlIGhhZCB0
aGF0IGFuZCBtb3ZlZCBhd2F5IGZyb20gaXQgYmVjYXVzZSB0aGUgc2NoZWR1bGVyIGxpc3QgaXMg
CmFjdHVhbGx5IGNvbnN0IGFuZCBzaG91bGRuJ3QgYmUgYWxsb2NhdGVkIHdpdGggZWFjaCBlbnRp
dHkgKHdoaWNoIHdlIGNhbiAKZWFzaWx5IGhhdmUgdGhvdXNhbmRzIG9mKS4KClJlZ2FyZHMsCkNo
cmlzdGlhbi4KCj4gICAoaW4gd2hpY2ggY2FzZQo+IHdlIGNhbiBzaW1wbHkgaW5kZXgtcGFyYW1l
dGVyaXplIGl0IGFuZCBzaW1wbHkgY29weSBpdC4KPiBXaHkgYXJlIHRoZXJlIHNvIG1hbnkgY2hl
Y2tzIGV2ZXJ5d2hlcmU/Cj4KPj4gKwllbnRpdHktPm51bV9zY2hlZF9saXN0ID0gbnVtX3NjaGVk
X2xpc3Q7Cj4+ICsKPiBJIG1lYW4sIGFsbCB3ZSdyZSBkb2luZyBpbiB0aGlzIGZ1bmN0aW9uIGlz
IGluaXRpYWxpemluZwo+IGVudGl0eS0+c2NoZWRfbGlzdCBhbmQgZW50aXR5LT5udW1fc2NoZWRf
bGlzdC4gV2h5IGRvZXMgdGhpcwo+IGZ1bmN0aW9uIGhhdmUgdG8gYmUgc28gY29tcGxleCBhbmQg
ZG8gc28gbWFueSBjaGVja3M/Cj4gQ2FuIHdlIGltcHJvdmUvZml4IHRoZSBhcmNoaXRlY3R1cmUg
aW5zdGVhZD8KPgo+IFJlZ2FyZHMsCj4gTHViZW4KPgo+Cj4+ICsJcmV0dXJuIDA7Cj4+ICt9Cj4+
ICtFWFBPUlRfU1lNQk9MKGRybV9zY2hlZF9lbnRpdHlfbW9kaWZ5X3NjaGVkKTsKPj4gKwo+PiAg
IC8qKgo+PiAgICAqIGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZSAtIENoZWNrIGlmIGVudGl0eSBp
cyBpZGxlCj4+ICAgICoKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIu
aCBiL2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaAo+PiBpbmRleCA1ODliZTg1MWY4YTEuLjBj
MTY0YTk2ZDUxYiAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oCj4+
ICsrKyBiL2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaAo+PiBAQCAtMjk3LDYgKzI5NywxMCBA
QCB2b2lkIGRybV9zY2hlZF9maW5pKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQpOwo+
PiAgIGludCBkcm1fc2NoZWRfam9iX2luaXQoc3RydWN0IGRybV9zY2hlZF9qb2IgKmpvYiwKPj4g
ICAJCSAgICAgICBzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAo+PiAgIAkJICAgICAg
IHZvaWQgKm93bmVyKTsKPj4gK2ludCBkcm1fc2NoZWRfZW50aXR5X21vZGlmeV9zY2hlZChzdHJ1
Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAo+PiArCQkJCSAgc3RydWN0IGRybV9ncHVfc2No
ZWR1bGVyICoqc2NoZWRfbGlzdCwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1bnNpZ25lZCBpbnQgbnVtX3NjaGVkX2xpc3QpOwo+PiArCj4+ICAgdm9pZCBkcm1fc2NoZWRf
am9iX2NsZWFudXAoc3RydWN0IGRybV9zY2hlZF9qb2IgKmpvYik7Cj4+ICAgdm9pZCBkcm1fc2No
ZWRfd2FrZXVwKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQpOwo+PiAgIHZvaWQgZHJt
X3NjaGVkX3N0b3Aoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCwgc3RydWN0IGRybV9z
Y2hlZF9qb2IgKmJhZCk7Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
