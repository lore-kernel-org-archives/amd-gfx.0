Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36907C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 18:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9782073A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 18:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9782073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5566E0D1;
	Fri, 15 Nov 2019 18:03:35 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740084.outbound.protection.outlook.com [40.107.74.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE0D6E0D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 18:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIxxnnbYL/YEPNl1zjftojG8pO5fxi6o8jDLPfzKhLCaHL6N3u05wjUjhdKuYZTGN5hNm+mtsQKus4IVlEsMzwuIX8jljlh0+3CST6vjtrtdNvRMSWyuPHjBepGnw4NOHX8MsKrR2FYA7ZhG3o7jZFYqaDviyefPqVzNsH6oZxz5xpZIFx+zcyE3Cvmx2NVL4ZmQ3FC7v9dX7e/rgjyqQ7GPkt4+Xf/cI2Jzva+yzOBskxTgfyLZw/T0F2G+EMvoVTJYgjNX2Nnxbpw/klo1J7WAacc+MAxdbNUs4UgxCjKWsqJOKId6SiIgVKqFA72Kav/Ci+P9mwRQT1liacMbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNqg6UihfzgaFgL8XkNsZAv4zYN/oAxsa1UdDN2nOcY=;
 b=X+HnbUYCmCYwmRo5biXBGCF3rY1eIFeIyM2dvU2juBtV9aiKjo4xjNwJwZ26glJGWHNAiI+K2ZQI2fose3vPk/omFfIU4fxZFzMNLu1GaVrk9dk18I/X9SHYlsA/q5KvW3n2wNBUlI+eaWhjLa6yI3q060UJLdOllZ3olYk94xlfOszmfT0t0Ldz4GhRlhGHqivHwwPmAvxR5jzVvd5RPHPnPSHNWS8bgHARwPhq5bGwUZ0cmpz2LB+zHE9Z7S1SNj5OXOmkl9abqU1ylBr4D6HUH9fxwGEABrJz7RDuyWqn4L9T1TUwNrUirm4jipwnQidSqQ7sycpq4YkP2i9GVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB4030.namprd12.prod.outlook.com (10.255.86.25) by
 MN2PR12MB3135.namprd12.prod.outlook.com (20.178.241.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Fri, 15 Nov 2019 18:03:31 +0000
Received: from MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::b9e3:2087:df4d:1e0a]) by MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::b9e3:2087:df4d:1e0a%6]) with mapi id 15.20.2451.029; Fri, 15 Nov 2019
 18:03:31 +0000
Subject: Re: [PATCH] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191115174314.73446-1-alex.sierra@amd.com>
From: Philip Yang <philip.yang@amd.com>
Message-ID: <bd9f76ca-9dc7-6c29-9c41-fc3e0d3c0bf1@amd.com>
Date: Fri, 15 Nov 2019 13:03:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
In-Reply-To: <20191115174314.73446-1-alex.sierra@amd.com>
Content-Language: en-GB
X-ClientProxiedBy: YTXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::23) To MN2PR12MB4030.namprd12.prod.outlook.com
 (2603:10b6:208:159::25)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99e01ff9-ead4-4bf0-ed71-08d769f61fed
X-MS-TrafficTypeDiagnostic: MN2PR12MB3135:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3135B294BBDA91EDA62459F2E6700@MN2PR12MB3135.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(189003)(199004)(53546011)(6506007)(86362001)(486006)(81156014)(446003)(50466002)(2616005)(476003)(6486002)(26005)(8676002)(81166006)(386003)(66946007)(2486003)(8936002)(4001150100001)(66556008)(99286004)(52116002)(36756003)(229853002)(66476007)(6436002)(6512007)(5660300002)(76176011)(6246003)(58126008)(31686004)(186003)(31696002)(11346002)(25786009)(14444005)(23676004)(316002)(3846002)(478600001)(230700001)(47776003)(7736002)(14454004)(2906002)(6116002)(305945005)(65806001)(65956001)(66066001)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3135;
 H:MN2PR12MB4030.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KVYqjccpKuhBwODfbn9HPJ1VUafYi/fghiN2VCWv1eaFHDi9OtwUObp8KjM2Iz/XXHBPvv9pfAdnfGAaqpqmgKcarfvCXRMIMOlVkmXA2kPnZK+JCM+/wF+FP3tEjaTHmt1GGuSbjQUOQ/rIAVUm9JYqQuRZ1nIYem9B3JXjJhDr+9nLlnDFLMHPvcdJsiq5A9Zicpuvk6VdQHTyRT0aU1FE9znM42gRY9S6ocQiH488YDYmMhTrbcpIjWJpTKN74VRR4Jr/Gdb41f2xN+BpQGvnIq1q5vaxyIw0EuEhOOSOzeAGDMI16dxscQ/88IkXcnrdlDdSJ7U2LzabgxhF5bXHGfHooki5hSYmZ64HXp8cZXrw/n6ld34FHK4avp2z0ViNx8gdio04mO12ptZCUE9dY0JrjB7WhlbI0iKex1QI8+BW+8XB50Gj9MwZO6do
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e01ff9-ead4-4bf0-ed71-08d769f61fed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 18:03:31.6651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKizDrhjKPhydfcqgUDwuNjjlpK5QGOtvnQypoZNe3LLrdzzRR7jd2e2rBEArAoV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3135
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNqg6UihfzgaFgL8XkNsZAv4zYN/oAxsa1UdDN2nOcY=;
 b=D9vGlIy9fbCd+/FHXsbiWI4TYCR/dxhvUBylEEVsTUMBkHRdWMrjCY4/vhGcbrHBB3wCOqXbwS2OJMSHYohzZx02A2SWYObNpd3TwACXys4YDIB50c2gSrIA5D3iExgbJKR1fhrVI3H+bZ40ePZ11N/Up1iH0ZCVofoBH06QJus=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Philip.Yang@amd.com; 
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
Message-ID: <20191115180330.SO-Fj02zNM3Lk11BRjSkC0M3-ZzBTskTG6VdH0HCaj4@z>

T25lIHN1Z2dlc3Rpb24gYmVsb3csIG1vdmUgdGhlIGZsYWdzIHNldHRpbmcgZm9yIGVsc2UgcGF0
aCBpbnRvIGVsc2UgCnBhdGggbG9va3MgYmV0dGVyLgoKUGhpbGlwCgpPbiAyMDE5LTExLTE1IDEy
OjQzIHAubS4sIEFsZXggU2llcnJhIHdyb3RlOgo+IEFmdGVyIGEgcmV0cnktZmF1bHQgaGFwcGVu
cywgdGhlIGZhdWx0IGhhbmRsZXIgd2lsbCBtb2RpZnkgdGhlIFVUQ0wyIHRvCj4gc2V0IFBURSBi
aXRzIHRvIGZvcmNlIGEgbm8tcmV0cnktZmF1bHQuIFRoaXMgd2lsbCBjYXVzZSB0aGUgd2F2ZSB0
bwo+IGVudGVyIHRoZSB0cmFwIGhhbmRsZXIuCj4gCj4gQ2hhbmdlLUlkOiBJMTc3MTAyODkxZjcx
NTA2OGYxNTYwNTk1N2ZmMjNiMGNhYjg2MjYwMwo+IFNpZ25lZC1vZmYtYnk6IEFsZXggU2llcnJh
IDxhbGV4LnNpZXJyYUBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgfCAxMyArKysrKy0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jCj4gaW5kZXggM2MwYmQ2NDcyYTQ2Li5lNGQxYThmYzk3ZDUgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC0zMTY3LDcgKzMxNjcsOCBA
QCBib29sIGFtZGdwdV92bV9oYW5kbGVfZmF1bHQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IHVuc2lnbmVkIGludCBwYXNpZCwKPiAgIAkJCSAgICB1aW50NjRfdCBhZGRyKQo+ICAgewo+ICAg
CXN0cnVjdCBhbWRncHVfYm8gKnJvb3Q7Cj4gLQl1aW50NjRfdCB2YWx1ZSwgZmxhZ3M7Cj4gKwl1
aW50NjRfdCB2YWx1ZSA9IDA7Cj4gKwl1aW50NjRfdCBmbGFnczsKPiAgIAlzdHJ1Y3QgYW1kZ3B1
X3ZtICp2bTsKPiAgIAlsb25nIHI7Cj4gICAKPiBAQCAtMzIwMCwxMyArMzIwMSw5IEBAIGJvb2wg
YW1kZ3B1X3ZtX2hhbmRsZV9mYXVsdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWdu
ZWQgaW50IHBhc2lkLAo+ICAgCQlBTURHUFVfUFRFX1NZU1RFTTsKPiAgIAogPi0JZmxhZ3MgPSBB
TURHUFVfUFRFX1ZBTElEIHwgQU1ER1BVX1BURV9TTk9PUEVEIHwKID4tCQlBTURHUFVfUFRFX1NZ
U1RFTTsKID4KPiAgIAlpZiAoYW1kZ3B1X3ZtX2ZhdWx0X3N0b3AgPT0gQU1ER1BVX1ZNX0ZBVUxU
X1NUT1BfTkVWRVIpIHsKPiAtCQkvKiBSZWRpcmVjdCB0aGUgYWNjZXNzIHRvIHRoZSBkdW1teSBw
YWdlICovCj4gLQkJdmFsdWUgPSBhZGV2LT5kdW1teV9wYWdlX2FkZHI7Cj4gLQkJZmxhZ3MgfD0g
QU1ER1BVX1BURV9FWEVDVVRBQkxFIHwgQU1ER1BVX1BURV9SRUFEQUJMRSB8Cj4gLQkJCUFNREdQ
VV9QVEVfV1JJVEVBQkxFOwogPiArCQkvKiBTZXR0aW5nIFBURSBmbGFncyB0byB0cmlnZ2VyIGEg
bm8tcmV0cnktZmF1bHQgICovCiA+ICsJCWZsYWdzID0gQU1ER1BVX1BURV9FWEVDVVRBQkxFIHwg
QU1ER1BVX1BERV9QVEUgfAogPiArCQkJQU1ER1BVX1BURV9URjsKCX0gZWxzZSB7Cj4gLQkJdmFs
dWUgPSAwOwogPisJCWZsYWdzID0gQU1ER1BVX1BURV9WQUxJRCB8IEFNREdQVV9QVEVfU05PT1BF
RCB8CiA+KwkJCUFNREdQVV9QVEVfU1lTVEVNOwogPiAgIAl9Cgo+ICAgCj4gICAJciA9IGFtZGdw
dV92bV9ib191cGRhdGVfbWFwcGluZyhhZGV2LCB2bSwgdHJ1ZSwgTlVMTCwgYWRkciwgYWRkciAr
IDEsCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
