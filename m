Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DC2C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 02:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F1B2073B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 02:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rWPomsgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F1B2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FC06EA48;
	Wed, 11 Dec 2019 02:26:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFD86EA48
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 02:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPNx++9eemwpWYlLLyUU+0pAH0buoHV6K2T2Zh1Fj8hZWGfL5vBUyCwAOALZKXSHkZLjH9x3jdlU8H7y+RQy8OJEzEZz8q+hAJ/+FXsAHcu8bT4+SLu+rbCQeTIVMOxf8RS2KxQGQqYm5r6ef/stdbhfV7groKkfB8C/uZ15q8ONshA2G/XAs1KzsMPdkrnUKdGTPnR+LG9LUEYZM7ZV+7mWzpoR0Zfm5VGKh9dZWdb1ws4NhjtYktHBbylU1HKZHkQjfSttQIB5B+PphoJqHXVh0mbY2Y9SpkouMHFlnwaTci6OK3TRYPo3S+/qVgqwV2BP52xuD+DU4QnXmqkkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RiOV+gWZv/BHVgStluqXKNZFywSlrdFuOuRlcyOoh0=;
 b=D4GWDTR+1CKySoWne+0RZwhUDv2VHexBhX7er0pQ54PA06CjorFlsZkWypF9/C3PAJjbDAt487V32bCuQXGCJEz1GyPYp+WDYFEnMPK1xe78t0PfA+YwZ77SiWlMPXWgyFJlLRxuG3Tg0iQ+j9LutWYk5T53Xz8ZmZc8pUTtx8uRl0UvlsLpsuROpJx/KLQL9+XTPbbZvIuvGrwnR8j7+n1jHfBsWsdkmKhtDy4XcWzBDJy0XR7U06GXvLWS6Qg2NR3UUSzFjr64u9JmgrsyLoSbJA3y6YGcAE/5qqzGO5TDMCtey24rjSMQSM1J1raFTo+aoN3X9WzCG1Dl56jOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RiOV+gWZv/BHVgStluqXKNZFywSlrdFuOuRlcyOoh0=;
 b=rWPomsgZfAFSalZww6uVIf4mUmuM7QAn+iqvt8DJsvqXaLFQs50Z4ERFEXowCbmywnCEezjBOBxBJJf3qDTG9/94VS0J8iO8Y9JdIfHG3jQdMAaDGTOqVrOqAKKmVFRvQT3NfxmIvbAwrAMF1XoIOVREYly+uzwTJMsXPuX/HqY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David1.Zhou@amd.com; 
Received: from MWHPR12MB1406.namprd12.prod.outlook.com (10.169.207.13) by
 MWHPR12MB1632.namprd12.prod.outlook.com (10.172.56.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.18; Wed, 11 Dec 2019 02:26:38 +0000
Received: from MWHPR12MB1406.namprd12.prod.outlook.com
 ([fe80::9490:6d95:7f3a:5302]) by MWHPR12MB1406.namprd12.prod.outlook.com
 ([fe80::9490:6d95:7f3a:5302%8]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 02:26:38 +0000
Subject: Re: [PATCH] drm/amdgpu: wait for all rings to drain before runtime
 suspending
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191210220804.1376829-1-alexander.deucher@amd.com>
From: zhoucm1 <david1.zhou@amd.com>
Organization: amd
Message-ID: <7c81d222-16d4-ad6f-a8f4-d90855930fc1@amd.com>
Date: Wed, 11 Dec 2019 10:26:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191210220804.1376829-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To MWHPR12MB1406.namprd12.prod.outlook.com
 (2603:10b6:300:14::13)
MIME-Version: 1.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b032365-7edf-4089-14af-08d77de18ce3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1632:|MWHPR12MB1632:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB16329D89151F1FAA5D63A94BB45A0@MWHPR12MB1632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(6506007)(36756003)(49246003)(8936002)(36916002)(2616005)(26005)(6666004)(81166006)(81156014)(8676002)(52116002)(186003)(31696002)(4326008)(15650500001)(498600001)(5660300002)(2906002)(6486002)(66556008)(6512007)(86362001)(66946007)(66476007)(31686004)(43062003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1632;
 H:MWHPR12MB1406.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+9//XsNWPL6GwUMLCir62U2WymhE9xK7aPCywIwkaMP9WSEtMK3QsMnkMARFrLzELnzMdfzidngeN3oXOPHwzAS712UvfUYgiYKiGAIRABdCN2iXu9rmfgNUEW2XWmWFdxQR5HuZUfLnR8nZlkMJiFIgbsCHxOvRxiIGgceONG/L+uJ3cdtAEuiBo606qwv/lsfDXPboUdrGXVibWzCpUmP+AImBxsytPQDybOEsQ5W4igEmSyg1yY/hZNRGwIiSU6+rITpWfqs1PD1YGd3KvgKYboUWTFDbR7UREugNblV5TAzhnZ0APJvZIQRov5ENktZ++N0imXVbipMR1vuLsbEhsWrQUlNxVKh3ERAcL7FqbDKe1ncq+xXBwkUbXwynHSceei9Ckz6fFp1MabmQ+k+Ld2geBJ42XFNcNrFcQY5mXtg7d35ZVJ4F0nkJ+Luxv4RgaqVeeM39pk4pOwBcwywU7NmTN5C3obZA4pDbqFAwwXFJdELVmPyy4gim/n2KW8z8YoTQF4WbhneHs91WQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b032365-7edf-4089-14af-08d77de18ce3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 02:26:38.4288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NO5ywWxmlbQ+n5MJXW4pMfxwCRMhFEkHAULksBJ+bJir/8WIBehxeezZLoXtYi4a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1632
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

Ck9uIDIwMTkvMTIvMTEg5LiK5Y2INjowOCwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IEFkZCBhIHNh
ZmV0eSBjaGVjayB0byBydW50aW1lIHN1c3BlbmQgdG8gbWFrZSBzdXJlIGFsbCBvdXRzdGFuZGlu
Zwo+IGZlbmNlcyBoYXZlIHNpZ25hbGVkIGJlZm9yZSB3ZSBzdXNwZW5kLiAgRG9lc24ndCBmaXgg
YW55IGtub3duIGlzc3VlLgo+Cj4gV2UgYWxyZWFkeSBkbyB0aGlzIHZpYSB0aGUgZmVuY2UgZHJp
dmVyIHN1c3BlbmQgZnVuY3Rpb24sIGJ1dCB3ZQo+IGp1c3QgZm9yY2UgY29tcGxldGlvbiByYXRo
ZXIgdGhhbiBiYWlsaW5nLiAgVGhpcyBiYWlscyBvbiBydW50aW1lCj4gc3VzcGVuZCBzbyB3ZSBj
YW4gdHJ5IGFnYWluIGxhdGVyIG9uY2UgdGhlIGZlbmNlcyBhcmUgc2lnbmFsZWQgdG8KPiBhdm9p
ZCBtaXNzaW5nIGFueSBvdXRzdGFuZGluZyB3b3JrLgoKVGhlIGlkZWEgc291bmRzIE9LIHRvIG1l
LCBidXQgaWYgeW91IHdhbnQgdG8gZHJhaW4gdGhlIHJpbmdzLCB5b3Ugc2hvdWxkIAptYWtlIHN1
cmUgbm8gbW9yZSBzdWJtaXNzaW9uLCByaWdodD8KClNvIHlvdSBzaG91bGQgcGFyayBhbGwgc2No
ZWR1bGVycyBiZWZvcmUgd2FpdGluZyBmb3IgYWxsIG91dHN0YW5kaW5nIApmZW5jZXMgY29tcGxl
dGVkLgoKLURhdmlkCgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rydi5jIHwgMTIgKysrKysrKysrKystCj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kcnYuYwo+IGluZGV4IDJmMzY3MTQ2YzcyYy4uODEzMjJiMGE4YWNmIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+IEBAIC0xMjE0LDEzICsxMjE0LDIzIEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X3Btb3BzX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpk
ZXYpCj4gICAJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGRldik7Cj4gICAJc3Ry
dWN0IGRybV9kZXZpY2UgKmRybV9kZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7Cj4gICAJc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkcm1fZGV2LT5kZXZfcHJpdmF0ZTsKPiAtCWludCBy
ZXQ7Cj4gKwlpbnQgcmV0LCBpOwo+ICAgCj4gICAJaWYgKCFhZGV2LT5ydW5wbSkgewo+ICAgCQlw
bV9ydW50aW1lX2ZvcmJpZChkZXYpOwo+ICAgCQlyZXR1cm4gLUVCVVNZOwo+ICAgCX0KPiAgIAo+
ICsJLyogd2FpdCBmb3IgYWxsIHJpbmdzIHRvIGRyYWluIGJlZm9yZSBzdXNwZW5kaW5nICovCj4g
Kwlmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9SSU5HUzsgaSsrKSB7Cj4gKwkJc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nID0gYWRldi0+cmluZ3NbaV07Cj4gKwkJaWYgKHJpbmcgJiYgcmluZy0+
c2NoZWQucmVhZHkpIHsKPiArCQkJcmV0ID0gYW1kZ3B1X2ZlbmNlX3dhaXRfZW1wdHkocmluZyk7
Cj4gKwkJCWlmIChyZXQpCj4gKwkJCQlyZXR1cm4gLUVCVVNZOwo+ICsJCX0KPiArCX0KPiArCj4g
ICAJaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9jbyhkcm1fZGV2KSkKPiAgIAkJZHJtX2Rl
di0+c3dpdGNoX3Bvd2VyX3N0YXRlID0gRFJNX1NXSVRDSF9QT1dFUl9DSEFOR0lORzsKPiAgIAlk
cm1fa21zX2hlbHBlcl9wb2xsX2Rpc2FibGUoZHJtX2Rldik7Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
