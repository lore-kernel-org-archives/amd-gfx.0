Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3ABC2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 17:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C112051A
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 17:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rKc7ikbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C112051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CEC6EDEA;
	Tue, 21 Jan 2020 17:47:12 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690078.outbound.protection.outlook.com [40.107.69.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01CC26EDEA
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 17:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKhh7vpMnYAx1v27VUii3vuV7cW4yx1zuh6a/0RnP2nP8zy4z0tzcHbDICtGiUGNquD0IQIPb262VjWeJrCc5MYc0249Dfu9vJlex1KJwUSBUr2Y63behKiozixMzyggyv62Jcgz7RZ9RgSWRZaLMdV/AAuJL1ABjKcW23VjzCu4ZjDEpnZVN8k2SRr6Q9jFu++o4pFh0Sd9qZHtwkFebsbk29Y07+iiZMI/zF0oZP39Oq5zeu9jpFM87en2ZDGXVwH03X1nh7lZKJhmLLP97D5gpfhDNUItLpAmt2mIpw75C2UBVJWWLzc2PIMS8in4OU7DN8kHTNAyFxR8SEZQfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/lOhEVnKv5/+rzxEac77q2sBVMlNKcfL3ccWzyPncU=;
 b=YnO0fdW2GgkCxxpZUNpGMWTtGeV4XEjjKIXo683xkkWaXou4LHDumtxXYiNw54jr6l3KW0njDrLCanBHcOcRYjpmTs5C4U5VALhbYMSg6W4mgP4aXRXcpSvFiPr2/mt15EB0zWJimqmhxARpaNqlCLxIst0IASzKqpOHpdsuNDYIaY7Ka5KXmTOHwcW5aX+QHbijcQim0Nhs+KOSrCaEbk0Bb4AO6kmwXzF8SzAXXJGByhdjWHd4yDFYhblz/CpaEj7Z5G8cJM9d16XyhicjsGWRt5X5SPVPQPnFKbyIVz8gmhO8IRH8V7POcG6/vbMd3GXPk8Fossmrv52LFdmxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/lOhEVnKv5/+rzxEac77q2sBVMlNKcfL3ccWzyPncU=;
 b=rKc7ikbJ614DrPiSZ2roZd/lxBrltViL7mADWKtRMzQzAyzq4YP5bY/w/ebICzjQ/sgfQKCCsDADZsXra08KXuAkwecVlXxb6BxoJjodQQFHFep3nR52htCg2UU8pR+VGvCPidAKQNmU1nIaRxKKrEZydgEbJJG8TdUNLNCm+a8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB2709.namprd12.prod.outlook.com (20.176.254.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Tue, 21 Jan 2020 17:47:07 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 17:47:07 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu/vcn2.5: fix a bug for the 2nd vcn instance
To: Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
 <1579623556-30941-2-git-send-email-James.Zhu@amd.com>
 <9a367f37-2531-3966-7904-40cbe4a290d0@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <afe66ec7-d2c5-c0eb-8809-54581a7139c2@amd.com>
Date: Tue, 21 Jan 2020 12:47:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <9a367f37-2531-3966-7904-40cbe4a290d0@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::18) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from [172.27.233.155] (165.204.55.251) by
 YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Tue, 21 Jan 2020 17:47:06 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a60aad42-6e93-4c65-c337-08d79e99eef1
X-MS-TrafficTypeDiagnostic: BYAPR12MB2709:|BYAPR12MB2709:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB270914E95524A3202215D6ADE40D0@BYAPR12MB2709.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(5660300002)(2906002)(31696002)(6486002)(2616005)(186003)(16526019)(26005)(36756003)(36916002)(956004)(53546011)(52116002)(31686004)(16576012)(66946007)(66556008)(81166006)(8676002)(81156014)(478600001)(110136005)(8936002)(66476007)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2709;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZ9GoXesRwwooyiRXt9/JJm6KZLpNx85CT/ClPjP76lR6hI6snAwIqANZlZXgXZ9GrbSeetvj1sURDv00N2KGYbtAu7yaIlOIKFV34t3z/OANBouFB3T39QESP8cACbYNr6eLSz6+kk92kvAOhf5yRCJI6mghndaD/neiOyaqXWBBmwv8yUjt5Xp9+d7x+pQEZXIO001rcqgqbyJimn9WOPVVuil/T7E1shRh4kn/FsiEi5wbcUAOv6o4sohSp6RTdvRUeTj7xLMxybBgdk5B9sWG0gZSz7ZQ+G9jSBnRKn44XQBoYzJeaL88kmSgdy0avdaqtVQRTCHXJKV5tcDR3cb4XLFgEHI8S/nWRgTt7u3C1DiKNpAdfIyY4VFHjKvHAWZhcgJaGhdyZVC0IaSwxxMUbsb0oCiaImn1bO67t3X5ikH3PNEHbWBjmNV8wnB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60aad42-6e93-4c65-c337-08d79e99eef1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 17:47:07.5419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5jMq25UK2eiWnMxPqIg2YvMQORQrVwVLNgS2yVEPp8Plh2ih/3Do03DaJdIG8sk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2709
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

Ck9uIDIwMjAtMDEtMjEgMTI6MjkgcC5tLiwgTGVvIExpdSB3cm90ZToKPgo+IE9uIDIwMjAtMDEt
MjEgMTE6MTkgYS5tLiwgSmFtZXMgWmh1IHdyb3RlOgo+PiBGaXggYSBidWcgZm9yIHRoZSAybmQg
dmNuIGluc3RhbmNlIGF0IHN0YXJ0IGFuZCBzdG9wLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKYW1l
cyBaaHUgPEphbWVzLlpodUBhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNuX3YyXzUuYyB8IDEyICsrKysrKysrLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92Y25fdjJfNS5jCj4+IGluZGV4IGMzNTFkMWEuLjc0MGEyOTEgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMKPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYwo+PiBAQCAtODkxLDggKzg5MSwxMCBA
QCBzdGF0aWMgaW50IHZjbl92Ml81X3N0YXJ0KHN0cnVjdCBhbWRncHVfZGV2aWNlIAo+PiAqYWRl
dikKPj4gwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgYWRldi0+dmNuLm51bV92Y25faW5zdDsg
KytpKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoYWRldi0+dmNuLmhhcnZlc3RfY29uZmln
ICYgKDEgPDwgaSkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+PiAt
wqDCoMKgwqDCoMKgwqAgaWYgKGFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfVkNOX0RQ
RykKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHZjbl92Ml81X3N0YXJ0X2RwZ19t
b2RlKGFkZXYsIGksIAo+PiBhZGV2LT52Y24uaW5kaXJlY3Rfc3JhbSk7Cj4+ICvCoMKgwqDCoMKg
wqDCoCBpZiAoYWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9WQ05fRFBHKSB7Cj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSB2Y25fdjJfNV9zdGFydF9kcGdfbW9kZShhZGV2LCBp
LCAKPj4gYWRldi0+dmNuLmluZGlyZWN0X3NyYW0pOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjb250aW51ZTsKPj4gK8KgwqDCoMKgwqDCoMKgIH0KPgo+ICJyIiBpcyBub3QgYmVpbmcgY29u
c2lkZXJlZCwgYW5kIGFmdGVyIHRoZSBsb29wLCBpdCB3aWxsIGJlIGdvaW5nIHRvIAo+IHRoZSBj
b2RlIGJlbG93LCBpcyBpdCBjb3JyZWN0PwpTaW5jZSBEUEcgbW9kZSBzdGFydC9zdG9wIGFsd2F5
cyByZXR1cm4gMC4gSSBoYXZlIGFkZGVkIGNvZGUgdG8gcmV0dXJuIDAgCmJlbG93IHVuZGVyIERQ
RyBtb2RlCj4KPgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLyogZGlzYWJsZSByZWdpc3RlciBhbnRp
LWhhbmcgbWVjaGFuaXNtICovCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBXUkVHMzJfUChTT0MxNV9S
RUdfT0ZGU0VUKFVWRCwgaSwgbW1VVkRfUE9XRVJfU1RBVFVTKSwgMCwKPj4gQEAgLTkwMyw2ICs5
MDUsOSBAQCBzdGF0aWMgaW50IHZjbl92Ml81X3N0YXJ0KHN0cnVjdCBhbWRncHVfZGV2aWNlIAo+
PiAqYWRldikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNShVVkQsIGksIG1tVVZE
X1NUQVRVUywgdG1wKTsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgICvCoMKgwqAgaWYgKGFkZXYtPnBn
X2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfVkNOX0RQRykKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVy
biAwOwo+PiArCj4+IMKgwqDCoMKgwqAgLypTVyBjbG9jayBnYXRpbmcgKi8KPj4gwqDCoMKgwqDC
oCB2Y25fdjJfNV9kaXNhYmxlX2Nsb2NrX2dhdGluZyhhZGV2KTsKPj4gwqAgQEAgLTEyOTQsMTAg
KzEyOTksOSBAQCBzdGF0aWMgaW50IHZjbl92Ml81X3N0b3Aoc3RydWN0IAo+PiBhbWRncHVfZGV2
aWNlICphZGV2KQo+PiDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT52Y24ubnVtX3Zj
bl9pbnN0OyArK2kpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChhZGV2LT52Y24uaGFydmVz
dF9jb25maWcgJiAoMSA8PCBpKSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGlu
dWU7Cj4+IC0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChhZGV2LT5wZ19mbGFncyAmIEFNRF9Q
R19TVVBQT1JUX1ZDTl9EUEcpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IHZj
bl92Ml81X3N0b3BfZHBnX21vZGUoYWRldiwgaSk7Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGdvdG8gcG93ZXJfb2ZmOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIH0KPgo+IHNhbWUgcHJvYmxlbSBhcyBhYm92ZSwgZG9uJ3QgZ28g
dGhyb3VnaCB0aGUgY29kZSB0aGF0IGlzbid0IG5lY2Vzc2FyeS4KCnNob3VsZCBiZSBmaW5lIHVu
ZGVyIERQRyBtb2RlLgoKSkFtZXMKCj4KPiBSZWdhcmRzLAo+Cj4gTGVvCj4KPgo+PiDCoCDCoMKg
wqDCoMKgwqDCoMKgwqAgLyogd2FpdCBmb3IgdmNuIGlkbGUgKi8KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
