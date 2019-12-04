Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF059C43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 23:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6035F20675
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 23:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6035F20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15CF56E946;
	Wed,  4 Dec 2019 23:05:48 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BBFB6E946
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 23:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTPEdxpvJ71Rn0flbL9hKXFmBBGm3SYzUs2bfYfS8o0dPww6StUCo4v3V7WSiGLFVOJAr3pmvaTmDFMrccz1fMYnCgAyJ/4uDlVw5asOU7+vavJH5HDuRMhGcc5kL0E0GQcACey6E0RBcoir5HWznv/2/LywS/i8/v0u07oCwiWszZqu1dkS5BUm7UcYGE/HIZ58CDYEhTfRCgVbDSjkRDW532ofyrLXApmqSFwSnEHNdhh+0ZTArAWt5OZWtAcsDxtT1yN5HCe/5OfmF0PXBHxCWthJ867mV3Vgb5gvfm8bTgFRPyHsq4mGSXIzmNcLm4zs0xc0KM8R/I6wfrSLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWxu9Gw7s/u8pi1szFG3Mcd1tHx9b+Mkr0lubqN/6AI=;
 b=XHES8wujS4LC5/cTh/creqcQAGIE98k6eTs2uIL1+QtE2xieMBGOG6LvPUw8t2223FtCrdiQAf2tT1XqBwpBYkpuKYDkggtUO8o95CUb3kamLAk6Z15Tk9bL+D0WWCSGP7FiX7XrTGYEtWD1vphav37tk9W192pm/owWIwPO87bogbKQUYt2128NJloxV/EUiI1oPFLsXX2JvtBsnoN63z4eUQlGMJdSRjzHS7z22zyx53GnrWKvU8JgLA9F6AAknNtKWQMqyQ6/+eihI4uhgCF9mciw5QuPSxPo92wAA4+zjSnfiYX4cMIHjRRGffXMf2QVFbvhTPwHpl9L1pjevA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB4188.namprd12.prod.outlook.com (10.141.185.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 4 Dec 2019 23:05:44 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2516.014; Wed, 4 Dec 2019
 23:05:44 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: explicitely sync to VM updates
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, philip.yang@amd.com
References: <20191204153822.2199-1-christian.koenig@amd.com>
 <20191204153822.2199-2-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <03541ca3-157b-171a-2562-081f2ca316c8@amd.com>
Date: Wed, 4 Dec 2019 18:05:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191204153822.2199-2-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::27) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18e4a75b-c6ab-4ebc-2415-08d7790e7daf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4188:|DM6PR12MB4188:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41887A9068134D8571BC3488925D0@DM6PR12MB4188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(8676002)(66574012)(15650500001)(6636002)(31686004)(81166006)(31696002)(81156014)(478600001)(44832011)(36756003)(99286004)(7736002)(6512007)(305945005)(25786009)(5660300002)(6246003)(65956001)(14454004)(3846002)(2906002)(2870700001)(66556008)(52116002)(11346002)(229853002)(66476007)(14444005)(186003)(23676004)(66946007)(36916002)(58126008)(6436002)(6486002)(316002)(50466002)(6116002)(8936002)(86362001)(6506007)(53546011)(26005)(76176011)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4188;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gC9pgvrVFP/3wQ3uY0zE9aD8kKb3Q7R8otp5YOStQbrHZS1VAAwS5fgiygDV8tqqN1J5KAaCrHh59QXSoc5Vr8oF5YVsFma+ldaWVwYjdTVCZ8XCkMRGfsIGvPepNDVL6fwk2gH7GmAYbse5eLp5cVYEL7r476druwrN/J047g+TSIsRbGpMYuTCPgb1CQJlzJbtGHUw4CN/TgiONMsoFrIH6WcOVd0uBdxV8yUYMD59u/woKeZpbKt2xcbH3+jwlcr2te9E3iFhtOrQ4wY81kRvXj/1k2pgFJMWM57ln+CA5+YpnIXT5+HXZj9qUrCL0yZmmcuUDdzT3RBY0qAZN93bzFuNWg5UbHExMWfqqfR0BPKNepW/azzM7CNler3y9TbpEsO1lnrRs4LztctnYuJzwl3PjiA+VMZu6x7b6pxO+qz/HxpzybbhMZb1LGv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e4a75b-c6ab-4ebc-2415-08d7790e7daf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 23:05:44.3296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8fkbe2OwuIFAvEA4aCKcLpjDfuZJJ4X+3wFQT0+Wh7C57n1ZY3RXO9aRK4pOoYYgfAaCG7fWcbZ3isPPVuzzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWxu9Gw7s/u8pi1szFG3Mcd1tHx9b+Mkr0lubqN/6AI=;
 b=fR936UKIlieiXrvxaOQFleAMdyT8kxaFBaulewmDtbWFbZ4sCXSpbyoCKjAD73hobkzM1ZgY7AvH7AZUjk527/zy9ynLufzd0KbODFuQLayoZ2A5mg5t3wMk83ClHvj1CqX/E6+ASdX7l9woJyZ2BdUPmvnpNniP66X+L1fwVec=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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

T24gMjAxOS0xMi0wNCAxMDozOCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFsbG93
cyB1cyB0byByZWR1Y2UgdGhlIG92ZXJoZWFkIHdoaWxlIHN5bmNpbmcgdG8gZmVuY2VzIGEgYml0
LgoKVGhpcyBhbGxvd3Mgc29tZSBmdXJ0aGVyIHNpbXBsaWZpY2F0aW9uLiBTZWUgdHdvIGNvbW1l
bnRzIGlubGluZS4KCgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2NzLmMgICB8IDE4ICsrKysrKystLS0tLS0tLS0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYyB8IDIyICsrKysrKysrKysrKysrKysrKystLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmggfCAgMiArKwo+ICAgMyBm
aWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gaW5kZXggOWUwYzk5NzYwMzY3Li5mMjE0
NzUzNTJiODggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2NzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+IEBA
IC03OTksMjkgKzc5OSwyNSBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc192bV9oYW5kbGluZyhzdHJ1
Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCkKPiAgIAlpZiAocikKPiAgIAkJcmV0dXJuIHI7Cj4gICAK
PiAtCXIgPSBhbWRncHVfc3luY19mZW5jZShhZGV2LCAmcC0+am9iLT5zeW5jLAo+IC0JCQkgICAg
ICBmcHJpdi0+cHJ0X3ZhLT5sYXN0X3B0X3VwZGF0ZSwgZmFsc2UpOwo+ICsJciA9IGFtZGdwdV9z
eW5jX3ZtX2ZlbmNlKGFkZXYsICZwLT5qb2ItPnN5bmMsCj4gKwkJCQkgZnByaXYtPnBydF92YS0+
bGFzdF9wdF91cGRhdGUpOwo+ICAgCWlmIChyKQo+ICAgCQlyZXR1cm4gcjsKPiAgIAo+ICAgCWlm
IChhbWRncHVfbWNicCB8fCBhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsKPiAtCQlzdHJ1Y3QgZG1h
X2ZlbmNlICpmOwo+IC0KPiAgIAkJYm9fdmEgPSBmcHJpdi0+Y3NhX3ZhOwo+ICAgCQlCVUdfT04o
IWJvX3ZhKTsKPiAgIAkJciA9IGFtZGdwdV92bV9ib191cGRhdGUoYWRldiwgYm9fdmEsIGZhbHNl
KTsKPiAgIAkJaWYgKHIpCj4gICAJCQlyZXR1cm4gcjsKPiAgIAo+IC0JCWYgPSBib192YS0+bGFz
dF9wdF91cGRhdGU7Cj4gLQkJciA9IGFtZGdwdV9zeW5jX2ZlbmNlKGFkZXYsICZwLT5qb2ItPnN5
bmMsIGYsIGZhbHNlKTsKPiArCQlyID0gYW1kZ3B1X3N5bmNfdm1fZmVuY2UoYWRldiwgJnAtPmpv
Yi0+c3luYywKPiArCQkJCQkgYm9fdmEtPmxhc3RfcHRfdXBkYXRlKTsKPiAgIAkJaWYgKHIpCj4g
ICAJCQlyZXR1cm4gcjsKPiAgIAl9Cj4gICAKPiAgIAlhbWRncHVfYm9fbGlzdF9mb3JfZWFjaF9l
bnRyeShlLCBwLT5ib19saXN0KSB7Cj4gLQkJc3RydWN0IGRtYV9mZW5jZSAqZjsKPiAtCj4gICAJ
CS8qIGlnbm9yZSBkdXBsaWNhdGVzICovCj4gICAJCWJvID0gdHRtX3RvX2FtZGdwdV9ibyhlLT50
di5ibyk7Cj4gICAJCWlmICghYm8pCj4gQEAgLTgzNSw4ICs4MzEsOCBAQCBzdGF0aWMgaW50IGFt
ZGdwdV9jc192bV9oYW5kbGluZyhzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCkKPiAgIAkJaWYg
KHIpCj4gICAJCQlyZXR1cm4gcjsKPiAgIAo+IC0JCWYgPSBib192YS0+bGFzdF9wdF91cGRhdGU7
Cj4gLQkJciA9IGFtZGdwdV9zeW5jX2ZlbmNlKGFkZXYsICZwLT5qb2ItPnN5bmMsIGYsIGZhbHNl
KTsKPiArCQlyID0gYW1kZ3B1X3N5bmNfdm1fZmVuY2UoYWRldiwgJnAtPmpvYi0+c3luYywKPiAr
CQkJCQkgYm9fdmEtPmxhc3RfcHRfdXBkYXRlKTsKPiAgIAkJaWYgKHIpCj4gICAJCQlyZXR1cm4g
cjsKPiAgIAl9Cj4gQEAgLTg0OSw3ICs4NDUsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc192bV9o
YW5kbGluZyhzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCkKPiAgIAlpZiAocikKPiAgIAkJcmV0
dXJuIHI7Cj4gICAKPiAtCXIgPSBhbWRncHVfc3luY19mZW5jZShhZGV2LCAmcC0+am9iLT5zeW5j
LCB2bS0+bGFzdF91cGRhdGUsIGZhbHNlKTsKPiArCXIgPSBhbWRncHVfc3luY192bV9mZW5jZShh
ZGV2LCAmcC0+am9iLT5zeW5jLCB2bS0+bGFzdF91cGRhdGUpOwo+ICAgCWlmIChyKQo+ICAgCQly
ZXR1cm4gcjsKPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfc3luYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYwo+
IGluZGV4IDk1ZTVlOTNlZGQxOC4uOWIyOGMxZWI1ZjQ5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfc3luYy5jCj4gQEAgLTE2MSw5ICsxNjEsNiBAQCBpbnQgYW1kZ3B1
X3N5bmNfZmVuY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfc3lu
YyAqc3luYywKPiAgIAo+ICAgCWlmICghZikKPiAgIAkJcmV0dXJuIDA7Cj4gLQlpZiAoYW1kZ3B1
X3N5bmNfc2FtZV9kZXYoYWRldiwgZikgJiYKPiAtCSAgICBhbWRncHVfc3luY19nZXRfb3duZXIo
ZikgPT0gQU1ER1BVX0ZFTkNFX09XTkVSX1ZNKQo+IC0JCWFtZGdwdV9zeW5jX2tlZXBfbGF0ZXIo
JnN5bmMtPmxhc3Rfdm1fdXBkYXRlLCBmKTsKCklmIHlvdSByZW1vdmUgdGhpcywgeW91IGNhbiBy
ZW1vdmUgdGhlIGFkZXYgcGFyYW1ldGVyIGZyb20gdGhpcyBmdW5jdGlvbi4KCgo+ICAgCj4gICAJ
aWYgKGFtZGdwdV9zeW5jX2FkZF9sYXRlcihzeW5jLCBmLCBleHBsaWNpdCkpCj4gICAJCXJldHVy
biAwOwo+IEBAIC0xNzksNiArMTc2LDI1IEBAIGludCBhbWRncHVfc3luY19mZW5jZShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9zeW5jICpzeW5jLAo+ICAgCXJldHVy
biAwOwo+ICAgfQo+ICAgCj4gKy8qKgo+ICsgKiBhbWRncHVfc3luY192bV9mZW5jZSAtIHJlbWVt
YmVyIHRvIHN5bmMgdG8gdGhpcyBWTSBmZW5jZQo+ICsgKgo+ICsgKiBAYWRldjogYW1kZ3B1IGRl
dmljZQo+ICsgKiBAc3luYzogc3luYyBvYmplY3QgdG8gYWRkIGZlbmNlIHRvCj4gKyAqIEBmZW5j
ZTogdGhlIFZNIGZlbmNlIHRvIGFkZAo+ICsgKgo+ICsgKiBBZGQgdGhlIGZlbmNlIHRvIHRoZSBz
eW5jIG9iamVjdCBhbmQgcmVtZW1iZXIgaXQgYXMgVk0gdXBkYXRlLgo+ICsgKi8KPiAraW50IGFt
ZGdwdV9zeW5jX3ZtX2ZlbmNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1k
Z3B1X3N5bmMgKnN5bmMsCj4gKwkJCSBzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSkKPiArewo+ICsJ
aWYgKCFmZW5jZSkKPiArCQlyZXR1cm4gMDsKPiArCj4gKwlhbWRncHVfc3luY19rZWVwX2xhdGVy
KCZzeW5jLT5sYXN0X3ZtX3VwZGF0ZSwgZmVuY2UpOwo+ICsJcmV0dXJuIGFtZGdwdV9zeW5jX2Zl
bmNlKGFkZXYsIHN5bmMsIGZlbmNlLCBmYWxzZSk7CgpMb29rcyBsaWtlIHlvdSBkb24ndCBuZWVk
IGFkZXYgaGVyZSBlaXRoZXIsIGJlY2F1c2UgeW91IGRvbid0IGhhdmUgdGhlIAphbWRncHVfc3lu
Y19zYW1lX2RldiBjb25kaXRpb24gYW55IG1vcmUuCgpSZWdhcmRzLAogwqAgRmVsaXgKCj4gK30K
PiArCj4gICAvKioKPiAgICAqIGFtZGdwdV9zeW5jX3Jlc3YgLSBzeW5jIHRvIGEgcmVzZXJ2YXRp
b24gb2JqZWN0Cj4gICAgKgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfc3luYy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMu
aAo+IGluZGV4IGI1ZjE3NzhhMjMxOS4uYWMyMTBkZDM0MzcxIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmgKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5oCj4gQEAgLTQyLDYgKzQyLDggQEAgc3RydWN0IGFt
ZGdwdV9zeW5jIHsKPiAgIHZvaWQgYW1kZ3B1X3N5bmNfY3JlYXRlKHN0cnVjdCBhbWRncHVfc3lu
YyAqc3luYyk7Cj4gICBpbnQgYW1kZ3B1X3N5bmNfZmVuY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIHN0cnVjdCBhbWRncHVfc3luYyAqc3luYywKPiAgIAkJICAgICAgc3RydWN0IGRtYV9m
ZW5jZSAqZiwgYm9vbCBleHBsaWNpdCk7Cj4gK2ludCBhbWRncHVfc3luY192bV9mZW5jZShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9zeW5jICpzeW5jLAo+ICsJCQkg
c3RydWN0IGRtYV9mZW5jZSAqZmVuY2UpOwo+ICAgaW50IGFtZGdwdV9zeW5jX3Jlc3Yoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCSAgICAgc3RydWN0IGFtZGdwdV9zeW5jICpzeW5j
LAo+ICAgCQkgICAgIHN0cnVjdCBkbWFfcmVzdiAqcmVzdiwKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
