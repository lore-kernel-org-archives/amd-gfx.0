Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C9BC33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 19:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE3824656
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 19:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yv4PlaRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE3824656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5238D8984E;
	Tue, 14 Jan 2020 19:20:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A529896EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 19:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOeARObm7Q7zteIz2WDjBHxzyho2lja1mhXkaNQ8nnGOzSC0tnTp8WIYYsxSavQOydJAnIVSAzWJpNVPl8NSjfMOklxFY1zB1buFVm3DFfYoIXqYPWNPK7xx9VJBMd38Perm12nph+jkVeQqNH1Qd/FSWJ8YD64/cSrWEWx+Vs+QdnAHy5vZQDXE3KBvAgQlBhTUzmYBjPJNoKut31U6DE/Bvrnj/yaO+hnm+rJh1/OwVRWL/zuWlzE35VZakmlHc/ua+Li6/FH+4lPTPmjfdgDzHL/wemfiuTN+VETFt0f1sKe3UkZivGGAZAMwYf+BpJPEBkdmEpmapDf8VV8FLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3vpF3BxVPHTWUdpsIp0MwVHauc+5puXuRMfj5ITCEo=;
 b=dgkEUqY126VbCIJUofokyFoaebDXdowyN2znzzzz7RrUbPVE14y7YpYbA8ty8V/ISBaHURvfXm7fDlcLutPCoC3hYnvjMZn0LrwL4CKTwJmer3AKHJxNnNJqX7GktCT3HStQbaoAXawJs04un23uY/nvk3ePi+g6l+Pe5yHNN9z7Fb0bg8Ag6I0z6qg86GuvagRxXttrcaM00X1+vcG47KYoyxBiOTbQ/ja/U3Ocioq9yZdAsIDxd/yKDkW4/VyTjEFmus/03YsxesSt1C58PwacsHWsyfKE31Y8RP4ULPtko4ZxjGMFH1zTYlhancmypZtvqUtpOvIDkUKBa6b7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3vpF3BxVPHTWUdpsIp0MwVHauc+5puXuRMfj5ITCEo=;
 b=Yv4PlaRL68kBNfl6tXaufIHx+9kL+Hn+ycANGEI24UG9Fl9aYPvkoSAz0I+9NdZXnsOZKOTeRrl0HmEDhwgmUYFGG7fXbKfogv9DHG4pEWS+2knSLaQ6Oq0azqbsfx0rUwOoGR4J3gw5YFfq6XrhSrT3yyE/iiENKS321AqO75s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3334.namprd12.prod.outlook.com (20.178.55.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 19:17:12 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 19:17:12 +0000
Subject: Re: [PATCH 2/6] drm/amdgpu/vcn2.5: add direct SRAM read and write
To: Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
 <1579024702-27996-3-git-send-email-James.Zhu@amd.com>
 <b5c0a2c0-dd11-b511-c5b9-d066c34842a8@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <3c7122e1-d440-3d82-7adb-1d5916ef189e@amd.com>
Date: Tue, 14 Jan 2020 14:17:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <b5c0a2c0-dd11-b511-c5b9-d066c34842a8@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::25) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from [172.27.233.155] (165.204.55.251) by
 YTXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Tue, 14 Jan 2020 19:17:11 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c62ecba-13ef-473e-845b-08d799265bb0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3334:|BYAPR12MB3334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33342E426780469E87B69687E4340@BYAPR12MB3334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(8936002)(81166006)(81156014)(5660300002)(36756003)(8676002)(16576012)(6486002)(316002)(110136005)(66946007)(26005)(66556008)(66476007)(16526019)(186003)(52116002)(2906002)(478600001)(53546011)(31696002)(956004)(31686004)(36916002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3334;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+TzxIuTDKa6LkOCz5TPW0TSoUIbZBVNHVrA4ye1TCL/NezttRerZT5UjdUZnP/x2G7P9FB/ejzuMIDp7959Xjj2ErcyPvk7fRuaDv5ofOVWCjXNxouGU9nYyVumyiQDUSoHYNU1hMPxuYXoEjQfqs7dMqy5b4uYGf3lbrjwsYwqowBduVqyDvCruyf9ZWLaP5Ume9uuDvFE1zMQ3OTSsCsZ65lODbGhz+E7kc1dK5gysBtTWJZZOvS19kdQKjmjwxPMJBp3BFEXN8xLrN2SVxKoKyk1SugcIL123r/vrZO8NJmbh9phtmGWSBFX0MxBI5Ym+wWIkFKKzGY8Ul3CVS0EwBc/B8q5ewWoS8e/jiuuv9Mle21rM5b+m9U1lk/rzwkjMLNcAvY6cbHT3fd1Cb6G9X3tpxqsMGX/LK1IqEE4N2BS2dmVuPPDqutPt+ic
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c62ecba-13ef-473e-845b-08d799265bb0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 19:17:12.4345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnxugOjYFhSbDxdnNjQHn78CjcLbcIoOyJ94wifhJH/HNWogjTWU7/CAVGccal6F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3334
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

U3VyZS4gVGhhbmtzIQoKSmFtZXMKCk9uIDIwMjAtMDEtMTQgMjowNiBwLm0uLCBMZW8gTGl1IHdy
b3RlOgo+IEkgdGhpbmsgeW91IGNhbiBhdm9pZCB0aGUgZHVwbGljYXRpb24sIGluc3RlYWQgYWRk
aW5nIGluc3RhbmNlIHRvIAo+ICJSUkVHMzIoV1JFRylfU09DMTVfRFBHX01PREVfMl8wKG9mZnNl
dCwgbWFza19lbikgIiwganVzdCBsaWtlIGFkZGluZyAKPiBpbnN0YW5jZSB0byBvdGhlciBwYXJ0
IG9mIHRoZSBjb2RlLgo+Cj4gUmVnYXJkcywKPgo+IExlbwo+Cj4KPiBPbiAyMDIwLTAxLTE0IDEy
OjU4IHAubS4sIEphbWVzIFpodSB3cm90ZToKPj4gQWRkIGRpcmVjdCBTUkFNIHJlYWQgYW5kIHdy
aXRlIE1BQ1JPIGZvciB2Y24yLjUKPj4KPj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxKYW1l
cy5aaHVAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92Y24uaCB8IDE4ICsrKysrKysrKysrKysrKysrKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwg
MTggaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Zjbi5oIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92Y24uaAo+PiBpbmRleCAyNmM2NjIzLi5kM2Q3NWVjIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+IEBAIC0xMjcsNiArMTI3LDI0IEBACj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCB9wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiDCoMKgwqDCoMKgIH0g
d2hpbGUgKDApCj4+IMKgICsjZGVmaW5lIFJSRUczMl9TT0MxNV9EUEdfTU9ERV8yXzUoaW5zdF9p
ZHgsIG9mZnNldCwgCj4+IG1hc2tfZW4pwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFwKPj4gK8KgwqDCoCAoe8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwKPj4gK8KgwqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNShWQ04sIGluc3QsIAo+PiBtbVVW
RF9EUEdfTE1BX0NUTCzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDB4MCA8PCBVVkRfRFBHX0xNQV9DVExfX1JFQURf
V1JJVEVfX1NISUZUIAo+PiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFza19lbiA8PCBVVkRfRFBHX0xNQV9DVExfX01BU0tfRU5f
X1NISUZUIAo+PiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgb2Zmc2V0IDw8IAo+PiBVVkRfRFBHX0xNQV9DVExfX1JFQURfV1JJVEVf
QUREUl9fU0hJRlQpKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gK8KgwqDCoMKgwqDCoMKg
IFJSRUczMl9TT0MxNShWQ04sIGluc3RfaWR4LCAKPj4gbW1VVkRfRFBHX0xNQV9EQVRBKTvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+ICvCoMKgwqAgfSkKPj4gKwo+
PiArI2RlZmluZSBXUkVHMzJfU09DMTVfRFBHX01PREVfMl81KGluc3RfaWR4LCBvZmZzZXQsIHZh
bHVlLCBtYXNrX2VuLCAKPj4gaW5kaXJlY3QpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFwKPj4gK8KgwqDCoCBkbyB7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiArwqDC
oMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1KFZDTiwgaW5zdF9pZHgsIG1tVVZEX0RQR19MTUFfREFU
QSwgCj4+IHZhbHVlKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gK8KgwqDCoMKgwqDCoMKg
IFdSRUczMl9TT0MxNShWQ04sIGluc3RfaWR4LCAKPj4gbW1VVkRfRFBHX0xNQV9DVEwswqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAo
MHgxIDw8IFVWRF9EUEdfTE1BX0NUTF9fUkVBRF9XUklURV9fU0hJRlQgfMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgXAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1hc2tfZW4gPDwgVVZEX0RQ
R19MTUFfQ1RMX19NQVNLX0VOX19TSElGVCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2Zmc2V0IDw8IAo+PiBVVkRfRFBHX0xNQV9DVExfX1JF
QURfV1JJVEVfQUREUl9fU0hJRlQpKTvCoMKgwqDCoMKgwqDCoCBcCj4+ICvCoMKgwqAgfSB3aGls
ZSAoMCkKPj4gKwo+PiDCoCBlbnVtIGVuZ2luZV9zdGF0dXNfY29uc3RhbnRzIHsKPj4gwqDCoMKg
wqDCoCBVVkRfUEdGU01fU1RBVFVTX19VVkRNX1VWRFVfUFdSX09OID0gMHgyQUFBQTAsCj4+IMKg
wqDCoMKgwqAgVVZEX1BHRlNNX1NUQVRVU19fVVZETV9VVkRVX1BXUl9PTl8yXzAgPSAweEFBQUEw
LApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
