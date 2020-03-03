Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECE3C3F2D1
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 19:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBC320866
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 19:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="abolmUP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBC320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F9289BD5;
	Tue,  3 Mar 2020 19:03:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E76C89BD5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 19:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQKhnRZJlMmoSPe1ifMjig2wTKdj3W9+ZV/BgBadfxuRiRv/OgANIbtwKidpObWMG/SGTuxLaMOXA93Lhcc8afW9eWT1jY6ulcMdaxpPiQp1HLsTOEyiMvIa2VBQquAzpFqBKOa8WhS7LfIwQjlWWHW0GtrPPXPpdu/a1hdWUu492sZLEyTYIPmGss4KZh6g52fF9OOd2vXekybwvlYozb/YjjGUw/Ewt3GYSkyjTuzd1by+GweFnnxcvk2/HxLzRkQLRwyqqu164bn2ehXnx2AUpobUvq8pfTdLKNFDbI9FKP0JB7Pr7dBZ9IcjvA6Y/XgtQv3qnY4LkIeQJm59Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H6hUXWfbi3HFayJSa7ovsK9v3C4HlrmDxuK5A5NlC4=;
 b=lfSTE8rAJtjju8QdTsxCB0sW/cDuR0W0TJjAMtqjqj8mUbW+1t/GTUpwBQ9a7l5hFrEeb8QK3bvaDg5e8KrfKJTwHsVd77Ujd0d/O7jdsG46vEnyAcoO7yLokjC84nmr+cHsaAhmpDsuxeXEOJbg1EOhetkBOT1SBvjUWTwOEZD1LNgPxaf6BxY1klLdFf3gBOW6j+UO5XmApkD0p/x7YyIbIIlerEga9VPNmH3YsRAVOUp2m0ZqA6z7DvCWsk59hGCKsAimLYtWdfBJ9o1OBsL9dB95deQHF4WIW9mLb460fp9IsAdGIxDT5xz1TtO+FkCILcGIBxJstVQZz4y+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H6hUXWfbi3HFayJSa7ovsK9v3C4HlrmDxuK5A5NlC4=;
 b=abolmUP7KcSUW3oBiU6T470QlSlPqq5A9zR8D0GAQ66gOWeX3rFl0X1Jb5B5KsbDUKF70TzLB3iopnIs3bITthqK84DHNSqcKCORu6SwoQXCHIOKXTacS20IcvtkEtCR0yDLftcdSqxGBmONzowe9nu7hbgO+xIwwUuVzPCUiSc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3349.namprd12.prod.outlook.com (2603:10b6:a03:ac::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:03:33 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:03:32 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu/vcn: fix race condition issue for vcn start
To: christian.koenig@amd.com, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
 <29c65b64-26d1-dfef-9da9-2563f291c2e8@gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <00b0a2df-a45c-43e6-9c7e-6567b0f86180@amd.com>
Date: Tue, 3 Mar 2020 14:03:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <29c65b64-26d1-dfef-9da9-2563f291c2e8@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::17) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YTOPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Tue, 3 Mar 2020 19:03:31 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90c0dd3b-5446-451a-116e-08d7bfa5911e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3349:|BYAPR12MB3349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33491B4EC504F1AF63843383E4E40@BYAPR12MB3349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(26005)(956004)(66556008)(66946007)(16526019)(186003)(66476007)(2616005)(478600001)(5660300002)(81166006)(8676002)(31686004)(81156014)(6486002)(2906002)(31696002)(52116002)(316002)(53546011)(66574012)(16576012)(36756003)(36916002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3349;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55fbWSaSrL6yuwuGghRScuOXCDGTDdZ+r+Zz0bNGzgoPHeTFJn29I0bwMVEf7/rEeLmh28E/qlcoHcgOwhDz9lI0eHo8PM19oIg50UHIqlN7kaGapuwNfaReHeJC4ZpB1f3jt0qKhkrmd09KVGnOpuVxgzrwL4BZnnF1kxy7ACNtRj4LCKLlOv9/pp8JLFWYdU2D4jk/1kf5BElincB2LOnZ4agznbqhODUjc2nBaQFHD4DIdKwnqq3YFkaHhSDwF/YshkepBHF9UUx5VZUGopJlM7AwEv8jdBHgKYharfCtPJ43593PdG+VmFO6D38PsW7zp9x7ERJKGP30q+RuWQ7W9lCQtTpLqzpwZIpfHjjPLuKqFLk2YZg9YPaAaEZJJBxkCIcYh1DTMK3Ldt5QIb9Si5d7+pN8q1DNhcmJIeBlmjs47j8C2xlHHLpknl0o
X-MS-Exchange-AntiSpam-MessageData: +rDXft0fsiluQoHTBKicgOpRneecanfVROU4/DIFV2JNZtqOM+mzbzpEhviWbVZxd2HiPjdXZ7T6ytxu59a7t5bAeuOsbnYaGAcHPI1+JtZkeaw/R/OK/3YlImTpNuOvDkyVDckojRbQjJ8ZzoiBog==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c0dd3b-5446-451a-116e-08d7bfa5911e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:03:32.3839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+D0TcXHR0tb8Zv19vI2u8Xn3dHGM2jQFXPqOIBnmWH0JJ8pvHwiowYAhyEr+Ast
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3349
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

Ck9uIDIwMjAtMDMtMDMgMTo0NCBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDAz
LjAzLjIwIHVtIDE5OjE2IHNjaHJpZWIgSmFtZXMgWmh1Ogo+PiBGaXggcmFjZSBjb25kaXRpb24g
aXNzdWUgd2hlbiBtdWx0aXBsZSB2Y24gc3RhcnRzIGFyZSBjYWxsZWQuCj4+Cj4+IFNpZ25lZC1v
ZmYtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgfCA0ICsrKysKPj4gwqAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIHwgMSArCj4+IMKgIDIgZmlsZXMgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdmNuLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Zjbi5jCj4+IGluZGV4IGY5NjQ2NGUuLmFhNzY2M2YgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4gQEAgLTYzLDYgKzYzLDcgQEAgaW50IGFtZGdw
dV92Y25fc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4gwqDCoMKgwqDCoCBp
bnQgaSwgcjsKPj4gwqAgwqDCoMKgwqDCoCBJTklUX0RFTEFZRURfV09SSygmYWRldi0+dmNuLmlk
bGVfd29yaywgCj4+IGFtZGdwdV92Y25faWRsZV93b3JrX2hhbmRsZXIpOwo+PiArwqDCoMKgIG11
dGV4X2luaXQoJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7Cj4+IMKgIMKgwqDCoMKgwqAgc3dpdGNo
IChhZGV2LT5hc2ljX3R5cGUpIHsKPj4gwqDCoMKgwqDCoCBjYXNlIENISVBfUkFWRU46Cj4+IEBA
IC0yMTAsNiArMjExLDcgQEAgaW50IGFtZGdwdV92Y25fc3dfZmluaShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIMKgwqDCoMKgwqAgcmVsZWFzZV9maXJt
d2FyZShhZGV2LT52Y24uZncpOwo+PiArwqDCoMKgIG11dGV4X2Rlc3Ryb3koJmFkZXYtPnZjbi52
Y25fcGdfbG9jayk7Cj4+IMKgIMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+IMKgIH0KPj4gQEAgLTMy
MSw2ICszMjMsNyBAQCB2b2lkIGFtZGdwdV92Y25fcmluZ19iZWdpbl91c2Uoc3RydWN0IGFtZGdw
dV9yaW5nIAo+PiAqcmluZykKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diA9IHJpbmctPmFkZXY7Cj4+IMKgwqDCoMKgwqAgYm9vbCBzZXRfY2xvY2tzID0gIWNhbmNlbF9k
ZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7Cj4+IMKgICvCoMKgwqAgbXV0
ZXhfbG9jaygmYWRldi0+dmNuLnZjbl9wZ19sb2NrKTsKPgo+IFRoYXQgc3RpbGwgd29uJ3Qgd29y
ayBjb3JyZWN0bHkgaGVyZS4KPgo+IFRoZSB3aG9sZSBpZGVhIG9mIHRoZSBjYW5jZWxfZGVsYXll
ZF93b3JrX3N5bmMoKSBhbmQgCj4gc2NoZWR1bGVfZGVsYXllZF93b3JrKCkgZGFuY2UgaXMgdGhh
dCB5b3UgaGF2ZSBleGFjdGx5IG9uZSB1c2VyIG9mIAo+IHRoYXQuIElmIHlvdSBoYXZlIG11bHRp
cGxlIHJpbmdzIHRoYXQgd2hvbGUgdGhpbmcgd29uJ3Qgd29yayBjb3JyZWN0bHkuCj4KPiBUbyBm
aXggdGhpcyB5b3UgbmVlZCB0byBjYWxsIG11dGV4X2xvY2soKSBiZWZvcmUgCj4gY2FuY2VsX2Rl
bGF5ZWRfd29ya19zeW5jKCkgYW5kIHNjaGVkdWxlX2RlbGF5ZWRfd29yaygpIGJlZm9yZSAKPiBt
dXRleF91bmxvY2soKS4KCkJpZyBsb2NrIGRlZmluaXRlbHkgd29ya3MuIEkgYW0gdHJ5aW5nIHRv
IHVzZSBhcyBzbWFsbGVyIGxvY2sgYXMgCnBvc3NpYmxlIGhlcmUuIHRoZSBzaGFyZSByZXNvdXJj
ZSB3aGljaCBuZWVkcyBwcm90ZWN0IGhlcmUgYXJlIHBvd2VyIApnYXRlIHByb2Nlc3MgYW5kIGRw
ZyBtb2RlIHN3aXRjaCBwcm9jZXNzLgoKaWYgd2UgbW92ZSBtdXRleF91bmxvY2soKSBiZWZvcmUg
c2NoZWR1bGVfZGVsYXllZF93b3JrKC4gSSBhbSB3b25kZXJpbmcgCndoYXQgYXJlIHRoZSBvdGhl
ciBuZWNlc3NhcnkgcmVzb3VyY2VzIHdoaWNoIG5lZWQgcHJvdGVjdC4KClRoYW5rcyEKCkphbWVz
Cgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPj4gwqDCoMKgwqDCoCBpZiAoc2V0X2Nsb2Nr
cykgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxz
ZSk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGlu
Z19zdGF0ZShhZGV2LCAKPj4gQU1EX0lQX0JMT0NLX1RZUEVfVkNOLAo+PiBAQCAtMzQ1LDYgKzM0
OCw3IEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3QgYW1kZ3B1X3Jpbmcg
Cj4+ICpyaW5nKQo+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+dmNuLnBhdXNlX2RwZ19t
b2RlKGFkZXYsIHJpbmctPm1lLCAmbmV3X3N0YXRlKTsKPj4gwqDCoMKgwqDCoCB9Cj4+ICvCoMKg
wqAgbXV0ZXhfdW5sb2NrKCZhZGV2LT52Y24udmNuX3BnX2xvY2spOwo+PiDCoCB9Cj4+IMKgIMKg
IHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2VuZF91c2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIAo+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaAo+PiBpbmRleCA2ZmUw
NTczLi4yYWUxMTBkIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmNuLmgKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zj
bi5oCj4+IEBAIC0yMDAsNiArMjAwLDcgQEAgc3RydWN0IGFtZGdwdV92Y24gewo+PiDCoMKgwqDC
oMKgIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqdmNuX2RlY19zY2hlZFtBTURHUFVfTUFYX1ZD
Tl9JTlNUQU5DRVNdOwo+PiDCoMKgwqDCoMKgIHVpbnQzMl90wqDCoMKgwqDCoMKgwqDCoCBudW1f
dmNuX2VuY19zY2hlZDsKPj4gwqDCoMKgwqDCoCB1aW50MzJfdMKgwqDCoMKgwqDCoMKgwqAgbnVt
X3Zjbl9kZWNfc2NoZWQ7Cj4+ICvCoMKgwqAgc3RydWN0IG11dGV4wqDCoMKgwqDCoMKgwqDCoCB2
Y25fcGdfbG9jazsKPj4gwqAgwqDCoMKgwqDCoCB1bnNpZ25lZMKgwqDCoCBoYXJ2ZXN0X2NvbmZp
ZzsKPj4gwqDCoMKgwqDCoCBpbnQgKCpwYXVzZV9kcGdfbW9kZSkoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
