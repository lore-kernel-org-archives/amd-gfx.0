Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7381DC432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 15:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510EA20678
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 15:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510EA20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E278926B;
	Tue, 26 Nov 2019 15:32:47 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690049.outbound.protection.outlook.com [40.107.69.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32A88926B
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 15:32:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJtp3sg8hFNfuRU3TJRbVoPVZnhBUYN5CJBwCWhsXsipymq7xfZ5ufKqEqW61s0bVC/shAPEpzOykkltP0CYz3A401DHNWGKMeIs9gC6AguKGcKLar0hKkEKW5jyYPyzLJaBbpK16lPgNLtWGfHjStBcGM/tEZZRBUSUCBKjH/A3bKMrqQTpzB+Dm9+JheHffAYhMcxdYxrNeHP+AH+ElYY/No/wDGyohFvbmkiVaJKdi43HDSOsVeQagDpUFBtxQFik1SHJ+2jR0YqHYfegQHgLp0MPM5Q73KO47B0Z2V0JOm3e8lV+Y7YgV0CIQ1MBLeQg4PFOc15/neK/5Ryu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryYBe1DzclGKUyDQJDXeYTYgrank8FPfDiWqQW6XtvI=;
 b=AA8M2K6F1MHdB/bv8/dF9uTEjVG0ZycoAe+7ITlDuwuMU97bXphNkQ1yKgBYdLAIk62Hzn3GeaYSGeftEqeCtt673fN3ERUUXonSA8pHzjyjy1eQM2y/tATB0lg2wIiaRj82s1IbSromU+utnuuUgXmngj0O/jFoShj8iQn34cUjmYl4EiM6MfZdVM9wEBVRBRPlpdfVo0asIRKlQctTH9hBEPdUKLf2eoGxF8WPq7HT/scsvrilQi3raVzB5GFFBU01AOWmB+klKaFStx4sqWl2Z3r2uQKCFFYPcodSzvuyz5VLMCuXHRUmAZP5HCndY7QC2nW5y9twLfWXw9ncVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3013.namprd12.prod.outlook.com (20.178.55.219) by
 BYAPR12MB3174.namprd12.prod.outlook.com (20.179.92.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 15:32:44 +0000
Received: from BYAPR12MB3013.namprd12.prod.outlook.com
 ([fe80::1174:3feb:de01:4fb9]) by BYAPR12MB3013.namprd12.prod.outlook.com
 ([fe80::1174:3feb:de01:4fb9%6]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 15:32:44 +0000
Subject: Re: [PATCH v7 11/17] drm/dp_mst: Add DSC enablement helpers to DRM
To: Leo <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191116220128.16598-1-mikita.lipski@amd.com>
 <20191116220128.16598-12-mikita.lipski@amd.com>
 <fe56a601-777d-f8db-c229-f155a162f100@amd.com>
From: Mikita Lipski <mlipski@amd.com>
Organization: AMD
Message-ID: <63d67b09-d7e7-f06b-628e-ed4248f5b9ec@amd.com>
Date: Tue, 26 Nov 2019 10:32:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <fe56a601-777d-f8db-c229-f155a162f100@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To BYAPR12MB3013.namprd12.prod.outlook.com
 (2603:10b6:a03:a9::27)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56dbdab2-b526-404f-d83d-08d77285e1cc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3174:|BYAPR12MB3174:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3174B50BA1B0A7B69C3D0ACBE4450@BYAPR12MB3174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(189003)(199004)(14454004)(25786009)(6436002)(230700001)(2906002)(6512007)(6486002)(4001150100001)(6306002)(6116002)(3846002)(229853002)(14444005)(446003)(2616005)(11346002)(66066001)(65956001)(65806001)(5660300002)(47776003)(966005)(6246003)(66556008)(66476007)(66946007)(45080400002)(99286004)(305945005)(8936002)(316002)(7736002)(81156014)(81166006)(186003)(36756003)(52116002)(478600001)(53546011)(6506007)(386003)(31686004)(26005)(4326008)(36916002)(23676004)(2486003)(31696002)(76176011)(8676002)(50466002)(58126008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3174;
 H:BYAPR12MB3013.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OqLjQf97XPHcYFEnzD4MgTK5aHonuY8f0jhG3dIAhuWnb3mIuL2Z8q51FMDrOMoWUwIh9M2KqmMbZMu95lDR3AFapZi0E79P+8LGsopU12vqhvSjm+Wj17lAGF8/U7AhZegH1bQTIMEEwoOBJyi35I4/GSkiBUbA3Y+LoFtFk1vpi7Z1VgyymPftCulgu7hurqhSUUwelrwsuAssaOQhtFaXiUmdoSOjTQBklIDzCTdWu1lT1QJDJTsfDgUwgi71UrUOATkLsk9PsxWV2Rv/yQT48DFnGfEkIAuWSizRdotyL9yAz4LOIMt86TizqUH3uayrM9Z8hb2OWHYaXVcQEKoT6WPyRZs67kTrxpC4K5sUDbMoSteiZNcDV3TZRbv2mHKIUjybye3bm5caEWuCg1xEq/EAqiPTcXp+XAQ9rVSQsal7SImF0sOUwaEH/CNfjk985KAXkp2YyrwtPxf1/WRSecd3Lxeqbdbxj34S3PQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dbdab2-b526-404f-d83d-08d77285e1cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 15:32:44.3817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/rU7kfweBDBzQanL/82MFLznCQOjE0imsgkB5L9pHhf8uL0sEo21ZeEL8HE0Hv9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3174
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryYBe1DzclGKUyDQJDXeYTYgrank8FPfDiWqQW6XtvI=;
 b=WX+TLM56tZBYBf3qkYnLyI1gbS2JT5WEsP/BbRnC0JmOvuvJ9xKFAPmUVwQwlsEUhikENmRIlW4n1268AHHov1YK/j/wZZn0QAPS2MOZQVNHTMdHMWXbRX3lFICorKIz5K8HoQ/iqQpeUYugI3a+szsJQH4T4yEAaz7QrfgnSro=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mikita.Lipski@amd.com; 
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126153242.QofJTXuTia6bRJrE-grygAwh7lTnL7o3QQHW24nGySw@z>

CgpPbiAyNi8xMS8yMDE5IDEwOjI0LCBMZW8gd3JvdGU6Cj4gCj4gCj4gT24gMjAxOS0xMS0xNiA1
OjAxIHAubS4sIG1pa2l0YS5saXBza2lAYW1kLmNvbSB3cm90ZToKPj4gRnJvbTogTWlraXRhIExp
cHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgo+Pgo+PiBBZGRpbmcgYSBoZWxwZXIgZnVuY3Rp
b24gdG8gYmUgY2FsbGVkIGJ5Cj4+IGRyaXZlcnMgb3V0c2lkZSBvZiBEUk0gdG8gZW5hYmxlIERT
QyBvbgo+PiB0aGUgTVNUIHBvcnRzLgo+Pgo+PiBGdW5jdGlvbiBpcyBjYWxsZWQgdG8gcmVjYWxj
dWxhdGUgVkNQSSBhbGxvY2F0aW9uCj4+IGlmIERTQyBpcyBlbmFibGVkIGFuZCByYWlzZSB0aGUg
RFNDIGZsYWcgdG8gZW5hYmxlLgo+PiBJbiBjYXNlIG9mIGRpc2FibGluZyBEU0MgdGhlIGZsYWcg
aXMgc2V0IHRvIGZhbHNlCj4+IGFuZCByZWNhbGN1bGF0aW9uIG9mIFZDUEkgc2xvdHMgaXMgZXhw
ZWN0ZWQgdG8gYmUgZG9uZQo+PiBpbiBlbmNvZGVyJ3MgYXRvbWljX2NoZWNrLgo+Pgo+PiB2Mjog
c3F1YXNoIHNlcGFyYXRlIGZ1bmN0aW9ucyBpbnRvIG9uZSBhbmQgY2FsbCBpdCBwZXIKPj4gcG9y
dAo+Pgo+PiBDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4+IENj
OiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBNaWtpdGEg
TGlwc2tpIDxtaWtpdGEubGlwc2tpQGFtZC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2Ry
bS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMgfCA2MSArKysrKysrKysrKysrKysrKysrKysrKysrKysK
Pj4gICBpbmNsdWRlL2RybS9kcm1fZHBfbXN0X2hlbHBlci5oICAgICAgIHwgIDUgKysrCj4+ICAg
MiBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9k
cF9tc3RfdG9wb2xvZ3kuYwo+PiBpbmRleCA5NGJiMjU5YWI3M2UuLjk4Y2M5M2Q1ZGRkNyAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYwo+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jCj4+IEBAIC0zODc2LDYgKzM4
NzYsNjcgQEAgZHJtX2RwX21zdF9hdG9taWNfY2hlY2tfdG9wb2xvZ3lfc3RhdGUoc3RydWN0IGRy
bV9kcF9tc3RfdG9wb2xvZ3lfbWdyICptZ3IsCj4+ICAgCXJldHVybiAwOwo+PiAgIH0KPj4gICAK
Pj4gKy8qKgo+PiArICogZHJtX2RwX21zdF9hdG9taWNfZW5hYmxlX2RzYyAtIFNldCBEU0MgRW5h
YmxlIEZsYWcgdG8gT24vT2ZmCj4+ICsgKiBAc3RhdGU6IFBvaW50ZXIgdG8gdGhlIG5ldyBkcm1f
YXRvbWljX3N0YXRlCj4+ICsgKiBAcG9pbnRlcjogUG9pbnRlciB0byB0aGUgYWZmZWN0ZWQgTVNU
IFBvcnQKPiAKPiBzL0Bwb2ludGVyL0Bwb3J0Lwo+IApUaGFua3MsCndpbGwgdXBkYXRlIHRoZSBj
b21tZW50LgoKPj4gKyAqIEBwYm46IE5ld2x5IHJlY2FsY3VsYXRlZCBidyByZXF1aXJlZCBmb3Ig
bGluayB3aXRoIERTQyBlbmFibGVkCj4+ICsgKiBAcGJuX2RpdjogRGl2aWRlciB0byBjYWxjdWxh
dGUgY29ycmVjdCBudW1iZXIgb2YgcGJuIHBlciBzbG90Cj4+ICsgKiBAZW5hYmxlOiBCb29sZWFu
IGZsYWcgZW5hYmxpbmcgb3IgZGlzYWJsaW5nIERTQyBvbiB0aGUgcG9ydAo+PiArICoKPj4gKyAq
IFRoaXMgZnVuY3Rpb24gZW5hYmxlcyBEU0Mgb24gdGhlIGdpdmVuIFBvcnQKPj4gKyAqIGJ5IHJl
Y2FsY3VsYXRpbmcgaXRzIHZjcGkgZnJvbSBwYm4gcHJvdmlkZWQKPj4gKyAqIGFuZCBzZXRzIGRz
Y19lbmFibGUgZmxhZyB0byBrZWVwIHRyYWNrIG9mIHdoaWNoCj4+ICsgKiBwb3J0cyBoYXZlIERT
QyBlbmFibGVkCj4gCj4gV291bGQgYmUgZ29vZCB0byBkb2N1bWVudCB0aGUgcmV0dXJuIHZhbHVl
IGFzIHdlbGwuCj4gCj4+ICsgKgo+PiArICovCj4+ICtpbnQgZHJtX2RwX21zdF9hdG9taWNfZW5h
YmxlX2RzYyhzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCj4+ICsJCQkJIHN0cnVjdCBk
cm1fZHBfbXN0X3BvcnQgKnBvcnQsCj4+ICsJCQkJIGludCBwYm4sIGludCBwYm5fZGl2LAo+PiAr
CQkJCSBib29sIGVuYWJsZSkKPj4gK3sKPj4gKwlzdHJ1Y3QgZHJtX2RwX21zdF90b3BvbG9neV9z
dGF0ZSAqbXN0X3N0YXRlOwo+PiArCXN0cnVjdCBkcm1fZHBfdmNwaV9hbGxvY2F0aW9uICpwb3M7
Cj4+ICsJYm9vbCBmb3VuZCA9IGZhbHNlOwo+PiArCWludCB2Y3BpID0gMDsKPj4gKwo+PiArCW1z
dF9zdGF0ZSA9IGRybV9hdG9taWNfZ2V0X21zdF90b3BvbG9neV9zdGF0ZShzdGF0ZSwgcG9ydC0+
bWdyKTsKPj4gKwo+PiArCWlmIChJU19FUlIobXN0X3N0YXRlKSkKPj4gKwkJcmV0dXJuIFBUUl9F
UlIobXN0X3N0YXRlKTsKPj4gKwo+PiArCWxpc3RfZm9yX2VhY2hfZW50cnkocG9zLCAmbXN0X3N0
YXRlLT52Y3BpcywgbmV4dCkgewo+PiArCQlpZiAocG9zLT5wb3J0ID09IHBvcnQpIHsKPj4gKwkJ
CWZvdW5kID0gdHJ1ZTsKPj4gKwkJCWJyZWFrOwo+PiArCQl9Cj4+ICsJfQo+PiArCj4+ICsJaWYg
KCFmb3VuZCkgewo+PiArCQlEUk1fREVCVUdfQVRPTUlDKCJbTVNUIFBPUlQ6JXBdIENvdWxkbid0
IGZpbmQgVkNQSSBhbGxvY2F0aW9uIGluIG1zdCBzdGF0ZSAlcFxuIiwKPj4gKwkJCQkgcG9ydCwg
bXN0X3N0YXRlKTsKPj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4+ICsJfQo+PiArCj4+ICsJaWYgKHBv
cy0+ZHNjX2VuYWJsZWQgPT0gZW5hYmxlKSB7Cj4+ICsJCURSTV9ERUJVR19BVE9NSUMoIltNU1Qg
UE9SVDolcF0gRFNDIGZsYWcgaXMgYWxyZWFkeSBzZXQgdG8gJWQsIHJldHVybmluZyAlZCBWQ1BJ
IHNsb3RzXG4iLAo+PiArCQkJCSBwb3J0LCBlbmFibGUsIHBvcy0+dmNwaSk7Cj4+ICsJCXZjcGkg
PSBwb3MtPnZjcGk7Cj4gCj4gRG8gd2Ugd2FudCB0byBlYXJseSByZXR1cm4gaGVyZT8KPiAKTm90
IGlmIGEgbmV3IGNvbXByZXNzaW9uIHJhdGUgaXMgc2V0LgpUaGUgRFNDIGNvdWxkIHN0aWxsIGJl
IGVuYWJsZWQsIGJ1dCB0aGUgbmV3IGRldmljZSBpcyBpbnRyb2R1Y2VkIC0gCmhpZ2hlciBjb21w
cmVzc2lvbiB3aWxsIGJlIHJlcXVpcmVkLCBzbyBQQk4gd2lsbCBjaGFuZ2UgYW5kIHdlIHdpbGwg
aGF2ZSAKdG8gcmVhc3NpZ24gdGhlIHNsb3RzIHRvIHRoZSBwb3J0LgoKCj4gLSBMZW8KPiAKPj4g
Kwl9Cj4+ICsKPj4gKwlpZiAoZW5hYmxlKSB7Cj4+ICsJCXZjcGkgPSBkcm1fZHBfYXRvbWljX2Zp
bmRfdmNwaV9zbG90cyhzdGF0ZSwgcG9ydC0+bWdyLCBwb3J0LCBwYm4sIHBibl9kaXYpOwo+PiAr
CQlEUk1fREVCVUdfQVRPTUlDKCJbTVNUIFBPUlQ6JXBdIEVuYWJsaW5nIERTQyBmbGFnLCByZWFs
bG9jYXRpbmcgJWQgVkNQSSBzbG90cyBvbiB0aGUgcG9ydFxuIiwKPj4gKwkJCQkgcG9ydCwgdmNw
aSk7Cj4+ICsJCWlmICh2Y3BpIDwgMCkKPj4gKwkJCXJldHVybiAtRUlOVkFMOwo+PiArCX0KPj4g
Kwo+PiArCXBvcy0+ZHNjX2VuYWJsZWQgPSBlbmFibGU7Cj4+ICsKPj4gKwlyZXR1cm4gdmNwaTsK
Pj4gK30KPj4gK0VYUE9SVF9TWU1CT0woZHJtX2RwX21zdF9hdG9taWNfZW5hYmxlX2RzYyk7Cj4+
ICAgLyoqCj4+ICAgICogZHJtX2RwX21zdF9hdG9taWNfY2hlY2sgLSBDaGVjayB0aGF0IHRoZSBu
ZXcgc3RhdGUgb2YgYW4gTVNUIHRvcG9sb2d5IGluIGFuCj4+ICAgICogYXRvbWljIHVwZGF0ZSBp
cyB2YWxpZAo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJtX2RwX21zdF9oZWxwZXIuaCBi
L2luY2x1ZGUvZHJtL2RybV9kcF9tc3RfaGVscGVyLmgKPj4gaW5kZXggZmMxOTA5NGIwNmMzLi5i
MWIwMGRlMzA4M2IgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvZHJtL2RybV9kcF9tc3RfaGVscGVy
LmgKPj4gKysrIGIvaW5jbHVkZS9kcm0vZHJtX2RwX21zdF9oZWxwZXIuaAo+PiBAQCAtNDMxLDYg
KzQzMSw3IEBAIHN0cnVjdCBkcm1fZHBfcGF5bG9hZCB7Cj4+ICAgc3RydWN0IGRybV9kcF92Y3Bp
X2FsbG9jYXRpb24gewo+PiAgIAlzdHJ1Y3QgZHJtX2RwX21zdF9wb3J0ICpwb3J0Owo+PiAgIAlp
bnQgdmNwaTsKPj4gKwlib29sIGRzY19lbmFibGVkOwo+PiAgIAlzdHJ1Y3QgbGlzdF9oZWFkIG5l
eHQ7Cj4+ICAgfTsKPj4gICAKPj4gQEAgLTY2Myw2ICs2NjQsMTAgQEAgZHJtX2RwX2F0b21pY19m
aW5kX3ZjcGlfc2xvdHMoc3RydWN0IGRybV9hdG9taWNfc3RhdGUgKnN0YXRlLAo+PiAgIAkJCSAg
ICAgIHN0cnVjdCBkcm1fZHBfbXN0X3RvcG9sb2d5X21nciAqbWdyLAo+PiAgIAkJCSAgICAgIHN0
cnVjdCBkcm1fZHBfbXN0X3BvcnQgKnBvcnQsIGludCBwYm4sCj4+ICAgCQkJICAgICAgaW50IHBi
bl9kaXYpOwo+PiAraW50IGRybV9kcF9tc3RfYXRvbWljX2VuYWJsZV9kc2Moc3RydWN0IGRybV9h
dG9taWNfc3RhdGUgKnN0YXRlLAo+PiArCQkJCSBzdHJ1Y3QgZHJtX2RwX21zdF9wb3J0ICpwb3J0
LAo+PiArCQkJCSBpbnQgcGJuLCBpbnQgcGJuX2RpdiwKPj4gKwkJCQkgYm9vbCBlbmFibGUpOwo+
PiAgIGludCBfX211c3RfY2hlY2sKPj4gICBkcm1fZHBfYXRvbWljX3JlbGVhc2VfdmNwaV9zbG90
cyhzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCj4+ICAgCQkJCSBzdHJ1Y3QgZHJtX2Rw
X21zdF90b3BvbG9neV9tZ3IgKm1nciwKPj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWls
bWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NtaWtpdGEubGlwc2tp
JTQwYW1kLmNvbSU3QzE5MjExMDE4NmFhOTRmZDAxM2JmMDhkNzcyODRjMDQ0JTdDM2RkODk2MWZl
NDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzEwMzc4NjgxODYxNTM4NSZhbXA7
c2RhdGE9Y2xNclZqb0Q2YVBXemtWeXhyJTJGREVzbEdabVRyQTJmeDN2RnA5T0RLRnU0JTNEJmFt
cDtyZXNlcnZlZD0wCj4gCgotLSAKVGhhbmtzLApNaWtpdGEgTGlwc2tpClNvZnR3YXJlIEVuZ2lu
ZWVyLCBBTUQKbWlraXRhLmxpcHNraUBhbWQuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
