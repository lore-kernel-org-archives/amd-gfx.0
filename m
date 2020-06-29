Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FACC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 16:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28DB925587
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 16:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zHoLzSW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DB925587
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D322F89C5E;
	Mon, 29 Jun 2020 16:14:00 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B190C89C5E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 16:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyHpRoxK3nVCVrtm12yKbXsc2ckQ1iY5WfIXYr6IRZVKHW6ELXRrIwnjQTZGAmdMnsnViiutmkrlZFUoz6yE4bFFMRIdDyDIDCU7+MMG9r4amjeDKi38anQyN9UlJNsD9d+dYuvAjB1tUdF+tFG7qiARA5JI2Rsq88e59d6qzcW6DgW1o2lzosT0kuu83518Bzf0rtrdrX1pE8FnuV5R6ZMl8DmPtAn/ONOrwHSaOjM44xh5Nu+kSsbtP7PkLkYTEFDOigYqSzj2xy8+qYPxNRcP4qOJ1eDlt8TnfkBjrYAg5AbYOgjkxYokDOi6O/pd2k7r2DKNv2bQDK5B1bsbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwnbPlWznofYL2FrUtWCSRTeABEgouFVtlcBpN8ogtI=;
 b=Tm2SwLsMCLx4yM9vaLKQJKQt56aiOXUS1rhwhHUR9upOI+DbM7XregV4s2IquPL+NZi5PbxrZ76vJ1BxJwajsclUGJ4V6mNf4ADEbgeJ0ZY3d2JFT0u3JYjy/tHMJAw7+NFZSLXDDW15CvRu+pDinfpmjdqcSTS/5Xk/4MW7juPWay46R6Y+vmweHZpBGXmd7qMHEm9tkKkJxhPxzHmeXcxTb4vvhwv+s0VAQjKUXAohqlChvooRuh5Zfu1v4aeU7fDw3W4y5UIV65Lc/vYocuNPeF/meYZ3dkN69Wu0/hqEJde7QuYIIpD48AEBED0kVNVsq5POj59FddnIlN4MCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwnbPlWznofYL2FrUtWCSRTeABEgouFVtlcBpN8ogtI=;
 b=zHoLzSW5OW6DqYrCWeu+jrX9pXKFvE0KXxuKXvNJv+nfTHCLvnpLyS0yr0AFVU+bEg2xwwuB1hV7itW5JsA30AZEsoZZefRykqEfXQf5L+sKJASxrqWTx+p6F/ZMXUWzXse6dIJz/c29YeyILl4NtLIUDmj7W8/5S2FXAoULaYs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2789.namprd12.prod.outlook.com (2603:10b6:a03:72::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 16:13:57 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::110f:a75f:beb8:96c6]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::110f:a75f:beb8:96c6%7]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 16:13:57 +0000
Subject: Re: [PATCH] Revert "drm/amd/display: Revalidate bandwidth before
 commiting DC updates"
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200629153652.101179-1-alexander.deucher@amd.com>
 <0af93aef-1173-58dd-f44a-5e2e36eba17c@amd.com>
Message-ID: <5f57c33d-dfd7-1f1f-f448-e05963caa9ec@amd.com>
Date: Mon, 29 Jun 2020 12:13:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <0af93aef-1173-58dd-f44a-5e2e36eba17c@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::28) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Mon, 29 Jun 2020 16:13:56 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8a87f59-adbc-4e28-1b75-08d81c476d0d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB27894B3FBF96EAD2516EB3EFEC6E0@BYAPR12MB2789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0G/O4VUQbdgANRO7cF86B0x/sxmFFzCaHwxmlAigzrrJjAgqv3YdHEfGh7XWaslH2qhLsNQcOvA5DWIn7+rlkrAc0HroNYi3C4zAi14cbB5PuotYM++T82q5g+AD5Mr0HsQvHKStObuppB7i4Mqq3vnYfYZ5nRGjt0oPCAkbrzHwUMgrzVoHtP9LfgotJ0e7HIZNQqALUOi8r5qYBpmelwc3k6Jf1Ts+vm/veIZkb5Y7bymRhmzVrFKfxIwybtjiWtAdKZ005YCUFetrTW+c1Ocm8bpl+MktNsT1eF0H51xEdVGzcxENBsYpwmOyMBbILswPZtssXV0FpKU3Eo3R2C8idoIt42hamuXmHcpcQVPlGMhmw8Yvvd1zyV492JxcOn3F+wtvQpNtfRlEnZeYrLgJDT4wCyPTG7UHFBZzJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(4326008)(8936002)(6666004)(36756003)(956004)(53546011)(5660300002)(83380400001)(16576012)(52116002)(2616005)(66946007)(86362001)(31696002)(66556008)(66476007)(316002)(6486002)(2906002)(8676002)(966005)(478600001)(26005)(31686004)(186003)(16526019)(15650500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: krtEknNCNW4RMIj4M2nZKzH7+W/0f9MtN+cCPGt07IOdW3B+mmNRVBqAk9KoE6WuKqd/KiDvabgfhNCtNEH4RdHCwCX3fKt2Lq0rlT9MjrwEAKugIuYaZaa38ZlhBLNijkZrkEMicWdLUBj0Mr95vmnIK0R1jmPylIHay9ksRcTIx6IOjB3pdJAtb0TwkJlKnL/EvMVOk6fkeY32xU1G0BnxMd1aXQ0VdaL26tlPbMXsWj8zG2RYlDdS5beFr6Rhx7XsBYC/ZQk6Oy+wPzUzga3zzft9L7WZZ0eRj9cbza3w+u9icNF0AwwZZnJd/yMyF4RGzx3tSRhcAfNHwvJS8mcZNxzIdot+hHOiDUh3+3zj96ZO9Im6g5Aov9vCNYh6nYykL1tGEXFgAngsOhnbLnXuLuYlTlcBgjP9TGKRgr6JH+kVtMjUGw+NjnQm4S/wR1/RjrL5bp/YPFf1wNQ6rCT2xvQIQ/Iz41Pe+4LVmtOP/xvaydmwcoZ2/zZ7PHc3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a87f59-adbc-4e28-1b75-08d81c476d0d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 16:13:57.2925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWqr4RyZ3agAA1om5HDdh0RkRsaIaY4HUY5I5J+jiMqOF1GCuxXq2o6yVDis/YOuvZo0wtToWfskDrqWRWGZMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2789
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wNi0yOSAxMTo0MCBhLm0uLCBLYXpsYXVza2FzLCBOaWNob2xhcyB3cm90ZToKPiBP
biAyMDIwLTA2LTI5IDExOjM2IGEubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPj4gU2VlbXMgdG8g
Y2F1c2Ugc3RhYmlsaXR5IGlzc3VlcyBmb3Igc29tZSB1c2Vycy4KPj4KPj4gVGhpcyByZXZlcnRz
IGNvbW1pdCBhMjRlYWE1YzUxMjU1YjM0NGQ1YTMyMWYxZWViMzIwNWYyNzc1NDk4Lgo+Pgo+PiBC
dWc6IAo+PiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8x
MTkxIAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+Cj4gCj4gSSBkb24ndCBzZWUgdGhlIGVycm9yIGluIHRoZWlyIGxvZy4gSG93IGRv
IHdlIGtub3cgdGhpcyBjb21taXQgaXMgCj4gYWN0dWFsbHkgY2F1c2luZyB0aGUgaXNzdWU/Cj4g
Cj4gSSBkb24ndCByZWFsbHkgd2FudCB0byByZXZlcnQgdGhpcyBjb21taXQgYmVjYXVzZSBpdCBt
ZWFucyB0aGF0IHdlIAo+IG1pc3NlZCByZWplY3RpbmcgYSBjb21taXQgZHVyaW5nIGF0b21pYyBj
aGVjaywgbWVhbmluZyB3ZSdyZSBlaXRoZXIgCj4gZ29pbmcgdG8gZ2V0IHVuZGVyZmxvdyBvbiB0
aGUgc2NyZWVuIG9yIGEgcGlwZSBoYW5nLgo+IAo+IFJlZ2FyZHMsCj4gTmljaG9sYXMgS2F6bGF1
c2thcwoKQWN0dWFsbHksIHdlIG9ubHkgd2FudCB0byBiZSBkb2luZyB0aGlzIG9uIGZ1bGwgdXBk
YXRlcyAtIGl0J3Mgbm90IGEgCnZlcnkgZmFzdCBvcGVyYXRpb24uIE5vdCBzdXJlIGlmIHRoaXMg
aXMgY2F1c2luZyB0aGVpciBzdGFiaWxpdHkgaXNzdWUgCnRob3VnaC4KClJlZ2FyZHMsCk5pY2hv
bGFzIEthemxhdXNrYXMKCj4gCj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvY29yZS9kYy5jIHwgNiAtLS0tLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRp
b25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kYy5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMK
Pj4gaW5kZXggNjc0MDJkNzVlNjdlLi45NDIzMGJiMzE5NWQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwo+PiBAQCAtMjYwNywxMiArMjYwNyw2IEBAIHZv
aWQgZGNfY29tbWl0X3VwZGF0ZXNfZm9yX3N0cmVhbShzdHJ1Y3QgZGMgKmRjLAo+PiDCoMKgwqDC
oMKgIGNvcHlfc3RyZWFtX3VwZGF0ZV90b19zdHJlYW0oZGMsIGNvbnRleHQsIHN0cmVhbSwgc3Ry
ZWFtX3VwZGF0ZSk7Cj4+IC3CoMKgwqAgaWYgKCFkYy0+cmVzX3Bvb2wtPmZ1bmNzLT52YWxpZGF0
ZV9iYW5kd2lkdGgoZGMsIGNvbnRleHQsIGZhbHNlKSkgewo+PiAtwqDCoMKgwqDCoMKgwqAgRENf
RVJST1IoIk1vZGUgdmFsaWRhdGlvbiBmYWlsZWQgZm9yIHN0cmVhbSB1cGRhdGUhXG4iKTsKPj4g
LcKgwqDCoMKgwqDCoMKgIGRjX3JlbGVhc2Vfc3RhdGUoY29udGV4dCk7Cj4+IC3CoMKgwqDCoMKg
wqDCoCByZXR1cm47Cj4+IC3CoMKgwqAgfQo+PiAtCj4+IMKgwqDCoMKgwqAgY29tbWl0X3BsYW5l
c19mb3Jfc3RyZWFtKAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRjLAo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNyZl91cGRhdGVzLAo+Pgo+IAo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeCAKPiAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
