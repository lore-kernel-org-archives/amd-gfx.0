Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B896C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 16:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0AB217AB
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 16:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0AB217AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE336E866;
	Thu, 28 Nov 2019 16:46:56 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690087.outbound.protection.outlook.com [40.107.69.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C4B6E866
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 16:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNoFP07PPpt+RXw0/cthdnOByk4QispZNcYL2By+BJyW+yh0IVqUzRrLXaQUJqM4b4vnSqQGRFsj4ymryJYUR/cjA68dgzEhqhUS5GOeJ1w5hPcO/3lV/5f8BXX/AbXMdu4+3752xRAxrXYfFI0669nJXIOnk+gH8BCte//o7CgvIGKxILkH9w0H3MiobYMYfOcOEyP0StW3D1sH5YY35q+Am9h7eFhEYOxx6pcfbGF8rSno0Wh2bPA4si5m3kMmcPevZWAW3Tmh7xLhEArBidiTGZsqod0CzpjUYPTgpCIktqx/vzCLoYuGn9Fsr32ldogXseytDBJrAceCyp3U4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoVOn3giG8WUa1iSd0q8HJjrkHTXxjHEYpErZ4wKW+s=;
 b=lXVJI3jjPTuAv7si/OJAFWnT3MVWACUB06X3E3JsWa/QSRrJIeauw3ZESbpWLwWVwqmNMDHkxHvw2Uv1caHOPBTrJ/O8cFNwFISqzcp0BjyIhSV+O6VxADZEUXCQ6prYDEBPR7btNxBsms64moFY4+ftHAtjD/uAas95BUkzq9buF0DC20608KKS2kywa2cKsO1Z2eQHxpIdF8jY+uy0fbyJg0ON7fY2YspVYGchOk9QDPNqu/4hWGg05hdCRsftavW1pQqYwvkuTuJpLih/Sijqx83sBjnCmlleJTTilLztHeL/9xFL1tD5i8gnB8s+8YrdWTrcua+/JRd8zWjZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3544.namprd12.prod.outlook.com (20.179.91.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 16:46:51 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0%7]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 16:46:51 +0000
Subject: Re: [PATCH] drm/amd/display: Drop AMD_EDID_UTILITY defines
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191128163320.20092-1-harry.wentland@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <4f694823-74ca-5c3d-5752-42252ae17a1d@amd.com>
Date: Thu, 28 Nov 2019 11:46:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191128163320.20092-1-harry.wentland@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::31) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eef95fa1-f224-4d63-f854-08d774229137
X-MS-TrafficTypeDiagnostic: BYAPR12MB3544:|BYAPR12MB3544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB354406A8080C326395863222EC470@BYAPR12MB3544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0235CBE7D0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(199004)(189003)(53546011)(386003)(6506007)(65806001)(6512007)(36756003)(65956001)(25786009)(31686004)(6116002)(6246003)(47776003)(2906002)(66066001)(230700001)(6486002)(4001150100001)(99286004)(316002)(50466002)(86362001)(58126008)(31696002)(6436002)(14454004)(478600001)(446003)(229853002)(66946007)(66556008)(66476007)(76176011)(2486003)(23676004)(11346002)(52116002)(2616005)(305945005)(8676002)(81156014)(3846002)(26005)(186003)(7736002)(81166006)(8936002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3544;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1v1x3htCWE7uvuvmdAsRCtPQQCmbBxLQ9/+T7J1BgZmFdBPkC+81wIACJjN4Qm8wHAnduQVlzWCC8bJQW70blu7ZxtjcBdpsbTdMgJsmbBBs5E88GMXI0gS0QqdEYQkJhvvJ6IV3qo9+V6jywoCNy7m/J8HTt56YuNjvBawVdBomahEeVJzxuXZDXLPvmPdckTTAUDRs9XyQpZP8l3nxzyJjwMlhtmu2yx1aiARRNKFUgu+Q9q3vGiE1EWtEIqtd8JtqLn3iKxN3weunGxZhsdRqsWG+FBzPfjSt3L/oNVvUkKWypfH5m+g41C/4e42RCatbqKCMr94yM/F2KViviPVFMv2qVCm4CJ4YkcIdGuuI9+KhBQ6Tx0pJE1C+fC5+l52greW+3ycjh8/TctcWhfn2lwWWkRgTxkK0aITst8S5ZcDvsif9tgyk1cMQZAb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef95fa1-f224-4d63-f854-08d774229137
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 16:46:51.2987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tgaj3pKwE6bpegzcjsTdjCG/9t5X5+x0mwdVwnr4OtC+/S5w502yn5Zrka/q+phP3nYmcuUtHbX7byDYPrbO1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3544
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoVOn3giG8WUa1iSd0q8HJjrkHTXxjHEYpErZ4wKW+s=;
 b=0ioeSh40+MmJcannLpmM82evQkOHkDaem7Rje29AQ53931/Mjs7icxgZO5ymDKKS+T3k6d9j4ZV6xHI6uB58U2OWyB9RZp/9RLHzGCnnar21SPYoU/RmLUeIls5Expq4uw7KV0TyAr0tR7SnecPYUiPKchR43VDxEJcU+icVy3Y=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Message-ID: <20191128164649.VyNNkUOjlqwu6CHAyTIqwCzajeRweb1445H5xmVLPK8@z>

T24gMjAxOS0xMS0yOCAxMTozMyBhLm0uLCBIYXJyeSBXZW50bGFuZCB3cm90ZToKPiBXZSBkb24n
dCB1c2UgdGhpcyB1cHN0cmVhbSBpbiB0aGUgTGludXgga2VybmVsLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6
IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmthemxhdXNrYXNAYW1kLmNvbT4KCj4gLS0t
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZHNjLmggICAgICB8IDIgLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19od190eXBlcy5oIHwgOCAtLS0t
LS0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3R5cGVzLmggICAgfCA0
IC0tLS0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19kc2MuaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY19kc2MuaAo+IGluZGV4IGE3ODJhZTE4YTFjNS4uY2M5OTE1
ZTU0NWNkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19k
c2MuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19kc2MuaAo+IEBA
IC00MSwxMCArNDEsOCBAQCBzdHJ1Y3QgZGNfZHNjX2J3X3JhbmdlIHsKPiAgIAo+ICAgc3RydWN0
IGRpc3BsYXlfc3RyZWFtX2NvbXByZXNzb3Igewo+ICAgCWNvbnN0IHN0cnVjdCBkc2NfZnVuY3Mg
KmZ1bmNzOwo+IC0jaWZuZGVmIEFNRF9FRElEX1VUSUxJVFkKPiAgIAlzdHJ1Y3QgZGNfY29udGV4
dCAqY3R4Owo+ICAgCWludCBpbnN0Owo+IC0jZW5kaWYKPiAgIH07Cj4gICAKPiAgIGJvb2wgZGNf
ZHNjX3BhcnNlX2RzY19kcGNkKGNvbnN0IHVpbnQ4X3QgKmRwY2RfZHNjX2Jhc2ljX2RhdGEsCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19od190eXBlcy5o
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2h3X3R5cGVzLmgKPiBpbmRleCA4
NjA0M2Q0MzFkNDAuLjI1YzUwYmNhYjllOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNfaHdfdHlwZXMuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY19od190eXBlcy5oCj4gQEAgLTI2LDggKzI2LDYgQEAKPiAgICNpZm5kZWYg
RENfSFdfVFlQRVNfSAo+ICAgI2RlZmluZSBEQ19IV19UWVBFU19ICj4gICAKPiAtI2lmbmRlZiBB
TURfRURJRF9VVElMSVRZCj4gLQo+ICAgI2luY2x1ZGUgIm9zX3R5cGVzLmgiCj4gICAjaW5jbHVk
ZSAiZml4ZWQzMV8zMi5oIgo+ICAgI2luY2x1ZGUgInNpZ25hbF90eXBlcy5oIgo+IEBAIC01ODQs
OCArNTgyLDYgQEAgc3RydWN0IHNjYWxpbmdfdGFwcyB7Cj4gICAJYm9vbCBpbnRlZ2VyX3NjYWxp
bmc7Cj4gICB9Owo+ICAgCj4gLSNlbmRpZiAvKiBBTURfRURJRF9VVElMSVRZICovCj4gLQo+ICAg
ZW51bSBkY190aW1pbmdfc3RhbmRhcmQgewo+ICAgCURDX1RJTUlOR19TVEFOREFSRF9VTkRFRklO
RUQsCj4gICAJRENfVElNSU5HX1NUQU5EQVJEX0RNVCwKPiBAQCAtNzQyLDggKzczOCw2IEBAIHN0
cnVjdCBkY19jcnRjX3RpbWluZyB7Cj4gICAJc3RydWN0IGRjX2RzY19jb25maWcgZHNjX2NmZzsK
PiAgIH07Cj4gICAKPiAtI2lmbmRlZiBBTURfRURJRF9VVElMSVRZCj4gLQo+ICAgZW51bSB0cmln
Z2VyX2RlbGF5IHsKPiAgIAlUUklHR0VSX0RFTEFZX05FWFRfUElYRUwgPSAwLAo+ICAgCVRSSUdH
RVJfREVMQVlfTkVYVF9MSU5FLAo+IEBAIC04MzcsNyArODMxLDUgQEAgc3RydWN0IHRnX2NvbG9y
IHsKPiAgIAl1aW50MTZfdCBjb2xvcl9iX2NiOwo+ICAgfTsKPiAgIAo+IC0jZW5kaWYgLyogQU1E
X0VESURfVVRJTElUWSAqLwo+IC0KPiAgICNlbmRpZiAvKiBEQ19IV19UWVBFU19IICovCj4gICAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3R5cGVzLmgg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfdHlwZXMuaAo+IGluZGV4IDEzNjNl
ODkwN2ZiZi4uMmI5MmJmYTI4YmRlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY190eXBlcy5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjX3R5cGVzLmgKPiBAQCAtMjUsNyArMjUsNiBAQAo+ICAgI2lmbmRlZiBEQ19UWVBFU19I
Xwo+ICAgI2RlZmluZSBEQ19UWVBFU19IXwo+ICAgCj4gLSNpZm5kZWYgQU1EX0VESURfVVRJTElU
WQo+ICAgLyogQU5EIEVkaWRVdGlsaXR5IG9ubHkgbmVlZHMgYSBwb3J0aW9uCj4gICAgKiBvZiB0
aGlzIGZpbGUsIGluY2x1ZGluZyB0aGUgcmVzdCBvbmx5Cj4gICAgKiBjYXVzZXMgYWRkaXRpb25h
bCBpc3N1ZXMuCj4gQEAgLTc4MSw5ICs3ODAsNiBAQCBzdHJ1Y3QgZGNfY2xvY2tfY29uZmlnIHsK
PiAgIAl1aW50MzJfdCBjdXJyZW50X2Nsb2NrX2toejsvKmN1cnJlbnQgY2xvY2sgaW4gdXNlKi8K
PiAgIH07Cj4gICAKPiAtI2VuZGlmIC8qQU1EX0VESURfVVRJTElUWSovCj4gLS8vQU1EIEVESUQg
VVRJTElUWSBkb2VzIG5vdCBuZWVkIGFueSBvZiB0aGUgYWJvdmUgc3RydWN0dXJlcwo+IC0KPiAg
IC8qIERTQyBEUENEIGNhcGFiaWxpdGllcyAqLwo+ICAgdW5pb24gZHNjX3NsaWNlX2NhcHMxIHsK
PiAgIAlzdHJ1Y3Qgewo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
