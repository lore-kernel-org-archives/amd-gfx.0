Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302AFC35DF5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 11:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E760420726
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 11:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jxN4sW07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E760420726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE0766EA8E;
	Tue, 25 Feb 2020 11:08:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A5926EA8E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 11:08:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTd4R2dM/wjnR2NAoHoQdW/KM4y+/k7IBLg+h3g4XSzuEXolsncEFJz7eGGV0IAVkaocpBHA59Sy6mc04kljQwwHvPruxIcDuSemdqeOg4LaoIwnFy5ljXjeUnDer8DWYCCmnp8TrMSO8bS/b/oJc7TjdtykPH+TFW68yslt06o4TKuStGi6kpg96d5K3rsDKqQstKK5Q9cVbiyjnevPBWUV0VBXkuAiCHKKaJASsYzFqpQy1yFMvjnSQid4BST9SwI5dVSok2Unhja3cxC58uzezvi8XZtaXmPNLdcjyCrntBZbbmfOUOeAwGfWNu16D1ldR/739AnvQeGDyTeuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiafjN3aeW1gt1pvmxROlVr7y6I9R6ryC+CSh8R8wd8=;
 b=CSgtkieSNGhLnw8oJzYOaMw6EL6JiAMC65MveoD1Saam0HtDw6YGJ9iQ49BLy7hFAp3mzbY9JE2KAkQAxZpWmLbuNB6xgdskHKawHNvwwOZWmhhoLku2o4z1CmPEObLdDuJLup2I1z2q/eK8IxMxSRmLOaCtMxy54a/b4FNE3iQ4inhyhpA7WSkdvcDG8REYz/Y/aXlP0PP9L+G+REWvA0t0DM+zJzCtlGwKeMDquJYrHf1AEsWlNx8/NMYHKTwwYUKOMh+OiLdue2CxvY7kH+BrZZvY3ZwRlt1WGyp4CSNg8db2a74WrztHVyZ+zwy6rUAR4fwPvmTZKMa+liv96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiafjN3aeW1gt1pvmxROlVr7y6I9R6ryC+CSh8R8wd8=;
 b=jxN4sW07IEcJkQFTb+oGJ7Ua/80A0jBMZkZ5OkQD1e+mPo3Tb289x/aYehZOYgJw7AchAMg333z1jNER2hOC4ahUJThhTgbf1YiBTHgoLl9MKMBV672+gAkzwyivaHHsG1YuiaaJSx3xCadCTjiNbzLAhWr9lnVOPyAVTeKBt3k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1801.namprd12.prod.outlook.com (2603:10b6:3:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 11:08:37 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2750.021; Tue, 25 Feb
 2020 11:08:37 +0000
Subject: Re: [PATCH] drm/amdgpu: do not modify ring before doing ring
 validation
To: Nirmoy <nirmodas@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200225103919.10158-1-nirmoy.das@amd.com>
 <95fdc800-b9f1-c2a5-184b-0e80b4e284f6@amd.com>
 <b1a6103f-fa9e-34d6-4fad-1fa1fe5141da@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <89487929-42c1-e333-81d2-2bfea7c00a0d@amd.com>
Date: Tue, 25 Feb 2020 12:08:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <b1a6103f-fa9e-34d6-4fad-1fa1fe5141da@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::19) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 11:08:36 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be7a6c6d-e420-476f-cb20-08d7b9e31019
X-MS-TrafficTypeDiagnostic: DM5PR12MB1801:|DM5PR12MB1801:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB180110048394453A77C78DB783ED0@DM5PR12MB1801.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(81156014)(66574012)(36756003)(4326008)(316002)(86362001)(81166006)(8676002)(5660300002)(66946007)(2906002)(2616005)(478600001)(16526019)(186003)(53546011)(6666004)(31686004)(6486002)(31696002)(52116002)(66476007)(66556008)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1801;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSaEfesW94gxL9GsnKqZOgfjRITvizNIV1UIELp6kJADDPXiF+THA/dA6P+9stft5o8Zr3NEAqP0MdToUWVkz6Rpv4vyMEMQ3nZbQcWZhPRAIdzTB5hXVuGd5cDd3KR0lIaZRoXVtRRlvAZQbey8+xRw4kknnLHjxP4esIDyKIzVU/3wkM5i3aWNmCI5u5rYTpT+U5YRgOkN0A6GBbpWQbv1ZhDWk66leU8QH8a3N7oR2uaGu/LTRyMIP7KWhvlzqMl+19ShU6kQate0NWkkGpryVxq+3oK28053AUaF8bmm8VpxQg8SzzmNzYEdVxF7spG55fu/O3LEPSeH7fyBBtLDwOmVcxqSZxqFy9+K0NvDcCmXhKA0VwShoQiKm4wwzkjqQVrPw11FBWCBV3lFvPX4je/iCqlYKvIipUA64mQBkHlBgtsrVHD+HmzVQeG6
X-MS-Exchange-AntiSpam-MessageData: rQz+U207kuyXrMsdOV0Gr43O/xVTKxiRxZ1OMCKMvwEvZkmvhcFdeZtg8T71lQo6dpiDwoq4xB31CsD53uEBLBgJoue7N7M88DWeiG/e7RA/+aco5I6BA/GtPOFK/Kcxu36MH5WPteEgABYPL5t4rHgUipRyvYHwB1xhO01ExBP2J5sGa2QXxus/si29dFy8pPtPck2Ly+QIJBEoLDULKQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7a6c6d-e420-476f-cb20-08d7b9e31019
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 11:08:37.7064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vuln4pQOoe2wpsIKdnmkgYNKvsCN/AXRZw8QgS/YyBdecAN9IFiRQ71TFgI88hM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1801
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjUuMDIuMjAgdW0gMTI6MDMgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAyLzI1LzIwIDExOjUy
IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAyNS4wMi4yMCB1bSAxMTozOSBzY2hy
aWViIE5pcm1veSBEYXM6Cj4+PiBjaGFuZ2luZyByaW5nLT5zY2hlZC5yZWFkeSBzaG91bGQgYmUg
ZG9uZSBvbmx5IGlmIHRoZSByaW5nIGlzIAo+Pj4gaW5pdGlhbGl6ZWQKPj4KPj4gSSBkb24ndCB0
aGluayB0aGF0IHRoaXMgbWFrZXMgbXVjaCBkaWZmZXJlbmNlLiBXaGVuIHRoZSByaW5ncyBhcmUg
Cj4+IGZyZWVkIHRoZSBoYXJkd2FyZSBhbmQgc29mdHdhcmUgc3RhY2sgbmVlZHMgdG8gYmUgZGlz
YWJsZWQgcXVpdGUgc29tZSAKPj4gdGltZSBiZWZvcmUuCj4KPiBZZXMgaXQgZG9lc24ndCBtYWtl
IGFueSBkaWZmZXJlbmNlLiBJIHdhbnRlZCBhbWRncHVfcmluZ19maW5pKCkgdG8gCj4gbG9vayBi
aXQgY2xlYW5lci4KCk9rLCB5b3Ugc2hvdWxkIG5vdGUgdGhhdCBpbiB0aGUgc3ViamVjdCBhbmQg
Y29tbWl0IG1lc3NhZ2UuIFNvbWV0aGluZyAKbGlrZSAiY2xlYW51cCBhbWRncHVfcmluZ19maW5p
IiAvICJDaGVjayB0aGUgcHJlcmVxdWlzaXRlcyBiZWZvcmUgdGhlIAphY3R1YWwgb3BlcmF0aW9u
Ii4KCk90aGVyd2lzZSBpZiB0aGF0IGlzIG5vdCBjbGVhcmx5IHN0YXRlIHNvbWVib2R5IG1pZ2h0
IHRoaW5rIHRoYXQgdGhpcyBpcyAKYSBidWcgZml4IGFuZCBwaWNrIGl0IHVwIGZvciBiYWNrcG9y
dGluZyBhbmQgd2UgcHJvYmFibHkgZG9uJ3Qgd2FudCB0aGF0LgoKUmVnYXJkcywKQ2hyaXN0aWFu
LgoKPgo+Cj4gUmVnYXJkcywKPgo+IE5pcm1veQo+Cj4+Cj4+IENocmlzdGlhbi4KPj4KPj4+Cj4+
PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+PiAtLS0K
Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMgfCAzICsrLQo+
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4K
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5j
IAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jCj4+PiBpbmRl
eCA1MzliZTEzODI2MGUuLjE4ZTExYjBmZGMzZSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMKPj4+IEBAIC0zNDQsMTIgKzM0NCwxMyBAQCBpbnQgYW1k
Z3B1X3JpbmdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAKPj4+ICphZGV2LCBzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcsCj4+PiDCoMKgICovCj4+PiDCoCB2b2lkIGFtZGdwdV9yaW5nX2Zpbmko
c3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+Pj4gwqAgewo+Pj4gLcKgwqDCoCByaW5nLT5zY2hl
ZC5yZWFkeSA9IGZhbHNlOwo+Pj4gwqAgwqDCoMKgwqDCoCAvKiBOb3QgdG8gZmluaXNoIGEgcmlu
ZyB3aGljaCBpcyBub3QgaW5pdGlhbGl6ZWQgKi8KPj4+IMKgwqDCoMKgwqAgaWYgKCEocmluZy0+
YWRldikgfHwgIShyaW5nLT5hZGV2LT5yaW5nc1tyaW5nLT5pZHhdKSkKPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm47Cj4+PiDCoCArwqDCoMKgIHJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7
Cj4+PiArCj4+PiDCoMKgwqDCoMKgIGFtZGdwdV9kZXZpY2Vfd2JfZnJlZShyaW5nLT5hZGV2LCBy
aW5nLT5ycHRyX29mZnMpOwo+Pj4gwqDCoMKgwqDCoCBhbWRncHVfZGV2aWNlX3diX2ZyZWUocmlu
Zy0+YWRldiwgcmluZy0+d3B0cl9vZmZzKTsKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
