Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C312FC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 15:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD3320775
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 15:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0uBgvMRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD3320775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40AA76EBE4;
	Thu, 25 Jun 2020 15:50:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F846EBE4
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 15:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evU8BXT7nFm9MCnzbz1GbL+dP0CeDwhKS6qVBXbYToczM2qL3M7azvd2xh6b2Ikw1/mZPgXDJ3/UEtdFpBa6tyJAFRsClmc3kQo4wAbtNZep0mC76CCIXtjr/0wPJ5bNjoHN1h8ZEF7CGSJJIDINtpD8xHElu+UKEn/K64+xjKQK7ghY1frOe/Vic3zKTUsOF9CeJ8Zo2wB6yd5AiYmL6uaS+uxTqiSEakVCrcSXBRWSUuLY0ZptR4Hws3+MuC+W4Hpmgkh2fLeJli8o0kXh4NjZoOoJGZkOJQCUtvG6GzdR8hudceQUaKYI26yOTWNYc3qJOuY+0tzhCdOE9AuX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn/K1w0aw1ghUrbk8zVMep/4uZdiabwFxwoN2yRs0Q8=;
 b=V18PPw+bofAMdIpyA7f7N7V8IHBGjg4+Vzf2i+d6Osrvd4m6A43cFnNdZK39e8BrWXBTO5YPq+MCeSShaX8hmslDBgCmVv6NywSfouAmoMZ4PJssGz+qOOln+KlQyepRfbeYbOi8k0qSiI3/p0wN10Zh9ESUEoTt5+/+8vld+Vu8J7Fd/9b2YdAaVRayVG9y39d5tji0qMBsGdIChh4ddA6Z0rKomKemEW50+9qEQWCjEsAyn2qeeEf36RRsa4Zr2oMeq21b6NVhKiTXANiRBbCNjZA+00mup7XL+/mW02eTDTibeq6BKtuBimvgiM4hgM3YRUMLLg38PXx6tW7z8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn/K1w0aw1ghUrbk8zVMep/4uZdiabwFxwoN2yRs0Q8=;
 b=0uBgvMRdowg4xRdQ5WKanjq1Ogpp7ZEU48kv4jThHVknAQosO5KrV7P7lCy0BX9qEln5il/aaTu6KwDjBru46C0DxSh301JRFPrUJ5ia4kNcvwGdxyotWbS1VN/ZEBh2MEl/TAPLYsWdaLrLSdufpBnNcMyT6GD92xlN12aajls=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3708.namprd12.prod.outlook.com (2603:10b6:5:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 15:50:26 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1%9]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 15:50:26 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Let KFD use more VMIDs on Arcturus
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200625031834.16122-1-Felix.Kuehling@amd.com>
 <20200625031834.16122-2-Felix.Kuehling@amd.com>
 <48a11576-b734-7525-dc39-c4aef67d5d35@gmail.com>
 <77c53962-fd2e-7004-76ab-aae4580a49b9@amd.com>
 <841359ec-a1cd-7722-55e6-182b6e2b6578@amd.com>
 <e3261861-cec0-09da-3632-be8e25a22844@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <abdd1def-1407-65f0-33b8-981efd5c6817@amd.com>
Date: Thu, 25 Jun 2020 17:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <e3261861-cec0-09da-3632-be8e25a22844@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0077.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::30) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Thu, 25 Jun 2020 15:50:25 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad7520de-89c7-4367-7fc6-08d8191f7a69
X-MS-TrafficTypeDiagnostic: DM6PR12MB3708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB370872E0A96140C948348FAB83920@DM6PR12MB3708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvCV3qxtixxGWE/DrP+DSE4vBzJcFOo7SB0A0kRyM+QEM5fmT6X1TeGD4Ndga96ees+SNAWyIWYlFK4U2c3uCdFDOfB3vvWqWOp7HV0Xbat7NrYDAfIdc+rx1RTJnnFWr4/8SMhKkCtjD8prX/jpQcppNrmYVWFH9dWYeEJwkneKCTpOztT6ORtz2DIAI2cKbTzE9kYqcB+jgixbPPItUFVGPdd9qI3VmsHyi1wUkp1EAUg7MvLB5KugeDv10p7iZicfGO2qfUJbsrwSp5OqCR3axonADE42ijbQZRN6FwRSsWlyeGDyEpx/V+KjSFQe73FumJuC7ovitGjStMLAcWsJpkR7eZRlwovQ6xh/wixw9cryAkRYBRVAdgFeL3HQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(478600001)(66946007)(66556008)(36756003)(66476007)(2906002)(6666004)(6486002)(16526019)(86362001)(186003)(31696002)(2616005)(316002)(5660300002)(83380400001)(31686004)(52116002)(8676002)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3xNbJr+MTwRHtE2b8bFMZdcJvWjFvpN424KmQHchgBwMyDUCrxgO8NOj5pU5lzuKUA+0boiaN6OmSZTP1MRHLCBLzZc2W+po+x6SQ8g/4hwD+5jbmSK673/1A39LEcoFC7elkFR2489DFf2qQFOTX2T/NJcZPffvAGVKm5VIPlSm8Y9vtOl0iqZeuGDVPWFVdN4MlB/clCPu7uex/cHEEuUyvSPvW++9nO/PUIRlOJLwJzUjoOfY0xbpkXe/KrOU7NB6ZgCxPOP8P9JMJAfB2Gml17o8sTX31Av4ZgBl3cGymf1E8FB9Fg3PWnII8gEWEGbYSBrv8NaJQxo8JwlWhlMQZzre9lFv5zNeiIsnNUeN79YuV0esRDad6E5/kQ3Sty4e4hEaD8+q6xabl9pT5G/J5hU5xqhGJdK+iVoZwInPxK3SlYhqCBHsYz7SGFP/xg8oZCZ+CNRSws9AdvS9gsqyW/EVipf8d9NUVEbJeA9ba7A987xspYdypRiOrRwQaT+9AbotylJ32LTrOGvPwgAbqir5Dpe4ibJaYjGYhsxCPYGKPOQHpjZE6vQDjMVw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7520de-89c7-4367-7fc6-08d8191f7a69
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 15:50:26.2544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIzthMhfKrl+udEEHkfQnvyZxp06uygV/Kjzcdqth0YsE79yOMQ8Qxlb1WMcH4Ya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3708
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

QW0gMjUuMDYuMjAgdW0gMTc6NDMgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIwLTA2
LTI1IHVtIDExOjM4IGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+PiBBbSAyNS4wNi4y
MCB1bSAxNzoxNSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4gQW0gMjAyMC0wNi0yNSB1bSA0
OjE5IGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4+IEFtIDI1LjA2LjIwIHVtIDA1
OjE4IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+Pj4+IFdoZW4gdGhlcmUgaXMgbm8gZ3JhcGhp
Y3Mgc3VwcG9ydCwgS0ZEIGNhbiB1c2UgbW9yZSBvZiB0aGUgVk1JRHMuCj4+Pj4+IEdyYXBoaWNz
Cj4+Pj4+IFZNSURzIGFyZSBvbmx5IHVzZWQgZm9yIHZpZGVvIGRlY29kaW5nL2VuY29kaW5nIGFu
ZCBwb3N0IHByb2Nlc3NpbmcuCj4+Pj4+IFdpdGgKPj4+Pj4gdHdvIFZDRSBlbmdpbmVzLCB0aGVy
ZSBpcyBubyByZWFzb24gdG8gcmVzZXJ2ZSBtb3JlIHRoYW4gMiBWTUlEcyBmb3IKPj4+Pj4gdGhh
dC4KPj4+PiBJSVJDIHRoZSBleHBlY3RhdGlvbiBpcyB0aGF0IHdlIHN0aWxsIHVzZSB0aGUgY29t
cHV0ZSBxdWV1ZXMgZm9yIHBvc3QKPj4+PiBwcm9jZXNzaW5nIGFuZCBub3QgdGhlIEtGRC4KPj4+
Pgo+Pj4+IFNvIHdlIHdpbGwgbmVlZCBhdCBsZWFzdCBWTUlEcyBmb3IgdGhhdCBhcyB3ZWxsLgo+
Pj4gQ29ycmVjdC4gUG9zdCBwcm9jZXNzaW5nIHVzZXMgY29tcHV0ZSBxdWV1ZXMgYW5kIFZNSURz
IGluIHRoZSBHRlhIVUIuCj4+PiBWQ0UgdXNlcyBWTUlEcyBpbiB0aGUgTU1IVUIuIEkgYmVsaWV2
ZSBpbiBNZXNhIHRoZXkgdXNlIHRoZSBzYW1lIFZNCj4+PiBjb250ZXh0LiBTbyBjYW4ndCB0aGV5
IHNoYXJlIHRoZSBzYW1lIFZNSURzPwo+PiBBaCEgR29vZCBwb2ludCwgQnV0IHdlIHN0aWxsIG5l
ZWQgYXQgbGVhc3QgMyBWTUlEIHdoZW4gVk1JRAo+PiByZXNlcnZhdGlvbiBpcyBhY3RpdmUuCj4g
SSBkb24ndCBrbm93IGFueXRoaW5nIGFib3V0IHRoYXQgVk1JRCByZXNlcnZhdGlvbiBmZWF0dXJl
LiBXaGF0IGlzIGl0Cj4gdXNlZCBmb3I/IFdobyBpcyB1c2luZyBpdD8gSG93IG1hbnkgVk1JRHMg
Y2FuIGJlIHJlc2VydmVkPwo+Cj4gSWYgb25lIFZNSUQgaXMgcmVzZXJ2ZWQsIHRoZXJlIHdvdWxk
IHN0aWxsIGJlIG9uZSBWTUlEIGxlZnQgZm9yIHZpZGVvCj4gcG9zdCBwcm9jZXNzaW5nLiBUaGF0
J3Mgbm90IGlkZWFsLCBidXQgSSBkb24ndCB0aGluayBpdCB3b3VsZCBiZSBmYXRhbC4KPiBCdXQg
aXMgaXQgYSByZWFsaXN0aWMgdXNlIGNhc2UgdGhhdCBWTUlEIHJlc2VydmF0aW9uIGFuZCBST0Nt
K3ZpZGVvCj4gcHJvY2Vzc2luZyB3b3VsZCBoYXBwZW4gb24gdGhlIHNhbWUgc3lzdGVtIGF0IHRo
ZSBzYW1lIHRpbWU/CgpWTUlEIHJlc2VydmF0aW9uIGlzIHVzZWQgZm9yIGRlYnVnZ2luZyBhbmQg
eWVzIHRoZXJlIGNhbiBvbmx5IGJlIG9uZSAKcmVzZXJ2ZWQuCgpCdXQgSSB0aGluayB3ZSBuZWVk
IGF0IGxlYXN0IHR3byBmb3IgZHluYW1pYyBhc3NpZ25tZW50IG9yIHdlIG1pZ2h0IHJ1biAKaW50
byBhIEJVR19PTigpIHdoaWxlIGdpdmluZyBWTUlEcyB0byBqb2JzLgoKQnV0IEkgY2VydGFpbmx5
IG5lZWQgdG8gdGVzdCB0aGlzIGFzIHdlbGwuIEl0J3MgcG9zc2libGUgdGhhdCAxIFZNSUQgCmlu
ZGVlZCB3b3JrcyBhcyBleHBlY3RlZC4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBUaGFua3Ms
Cj4gIMKgIEZlbGl4Cj4KPgo+PiBJIGRvbid0IHRoaW5rIHlvdSBjYW4gZ28gYmVsb3cgdGhpcy4K
Pj4KPj4gUmVnYXJkcywKPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4gUmVnYXJkcywKPj4+ICDCoMKgIEZl
bGl4Cj4+Pgo+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAgwqDCoCBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjlfMC5jIHwgMTEgKysrKysrKystLS0KPj4+Pj4gIMKgwqAgMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPj4+Pj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4+Pj4+IGluZGV4IDZlMTBiNDJjNTdl
NS4uMzQ3MDkyOWU1YjhlIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dt
Y192OV8wLmMKPj4+Pj4gQEAgLTEyNDUsMTAgKzEyNDUsMTUgQEAgc3RhdGljIGludCBnbWNfdjlf
MF9zd19pbml0KHZvaWQgKmhhbmRsZSkKPj4+Pj4gIMKgwqDCoMKgwqDCoCAvKgo+Pj4+PiAgwqDC
oMKgwqDCoMKgwqAgKiBudW1iZXIgb2YgVk1zCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoCAqIFZNSUQg
MCBpcyByZXNlcnZlZCBmb3IgU3lzdGVtCj4+Pj4+IC3CoMKgwqDCoCAqIGFtZGdwdSBncmFwaGlj
cy9jb21wdXRlIHdpbGwgdXNlIFZNSURzIDEtNwo+Pj4+PiAtwqDCoMKgwqAgKiBhbWRrZmQgd2ls
bCB1c2UgVk1JRHMgOC0xNQo+Pj4+PiArwqDCoMKgwqAgKiBhbWRncHUgZ3JhcGhpY3MvY29tcHV0
ZSB3aWxsIHVzZSBWTUlEcyAxLi5uLTEKPj4+Pj4gK8KgwqDCoMKgICogYW1ka2ZkIHdpbGwgdXNl
IFZNSURzIG4uLjE1Cj4+Pj4+ICvCoMKgwqDCoCAqCj4+Pj4+ICvCoMKgwqDCoCAqIFRoZSBmaXJz
dCBLRkQgVk1JRCBpcyA4IGZvciBHUFVzIHdpdGggZ3JhcGhpY3MsIDMgZm9yCj4+Pj4+ICvCoMKg
wqDCoCAqIGNvbXB1dGUtb25seSBHUFVzLiBPbiBjb21wdXRlLW9ubHkgR1BVcyB0aGF0IGxlYXZl
cyAyIFZNSURzCj4+Pj4+ICvCoMKgwqDCoCAqIGZvciB2aWRlbyBwcm9jZXNzaW5nLgo+Pj4+PiAg
wqDCoMKgwqDCoMKgwqAgKi8KPj4+Pj4gLcKgwqDCoCBhZGV2LT52bV9tYW5hZ2VyLmZpcnN0X2tm
ZF92bWlkID0gODsKPj4+Pj4gK8KgwqDCoCBhZGV2LT52bV9tYW5hZ2VyLmZpcnN0X2tmZF92bWlk
ID0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FSQ1RVUlVT
ID8gMyA6IDg7Cj4+Pj4+ICDCoMKgIMKgwqDCoMKgwqAgYW1kZ3B1X3ZtX21hbmFnZXJfaW5pdChh
ZGV2KTsKPj4+Pj4gICAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
