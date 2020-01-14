Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150FCC33CA9
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 00:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA58D207FD
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 00:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xD5zdfmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA58D207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 586536E1BA;
	Tue, 14 Jan 2020 00:45:20 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690084.outbound.protection.outlook.com [40.107.69.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E256E1BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 00:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7mC1Vhl/6yU2GfqErmzhWzB/dxPANTR5qBxezSVBtjpkcTjbcllI3z+0Rhs1IdyHO4kY3fICEZL66WocAE/84axBTqquuE53c5q6WsOAG3GunpTak9+ujtKb9wsZb3DlKfIZYFkoRs2QXCPaYGIxNDQhb4bwXvDZIYU6nfHIcSK3W7bbLzm7s8pAQFr6+hKP5xCbwdyAM+WIx1DThonIEtiUxWt/TeoazjDu88x4UMFRYe3v7UdM+Lx5QvJb+HyndGy1Md8m8T98JD0TKxRuDOc1lc6kHngjpKl1QwxAYS0STU0uvX51S5zsyyJj1H9YbnIJ+EoV7Uh6fZ3k9ZOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0IU5QrJmqzYqzGAEQKHDq5GV5wP8fFftIp5RPQ7tXQ=;
 b=IQcagE726+/2ia/TTnCLdMVI1bipOsK1Bdo+ohKSP4xeVeA0lF+iB9Gw/FiYSHOkwvuVrMxyeogkSxvhuQjL7CxARRY388mlcJMX49HZjPGfhK0dsji0+egv0FZqgsBoroLzXBgrDu1kn1DosY0WLgXKuHqvRQoSwjUpZZZqlFxLv5675q+FbQSMW830gj4+sSiPh0EwKWtlvU9rt51kKANh10C6QiKT2z6vD2RP1bu4qRezHaYnrkjvXSNLMOgo2KXpNQAGAEAa0HRRfLB5pdZCCnExo7d10Y1TAFez6bCzC7DTZDR5VQ6TJu3lV7DLUAzugdIuBG6GVV/RSJ8Izw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0IU5QrJmqzYqzGAEQKHDq5GV5wP8fFftIp5RPQ7tXQ=;
 b=xD5zdfmplHG2fjriQKAj+gjZBK5BXBW4suCFoIv4W5tvepDTwgMktG93KRlxRwyjIoo8C8sSqx7oBjnztk632tvkSP5gtBUlRf+314ToldDplWa9VGuyUcMtBq2lNKTuBQhPJ7/HkeBuJAG4Y/lRZCHlXMwfPd0YBUzAod02JwU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB2539.namprd12.prod.outlook.com (10.172.91.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 00:45:14 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 00:45:14 +0000
Subject: Re: [PATCH 3/7] drm/amdgpu: implement tlbs invalidate on gfx9 gfx10
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200113202629.94021-3-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <3a53be1d-80bf-14ad-3c7a-8160595241a6@amd.com>
Date: Mon, 13 Jan 2020 19:45:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200113202629.94021-3-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::41)
 To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Tue, 14 Jan 2020 00:45:14 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c4eb1a0-9cb8-46b4-ca32-08d7988b04c3
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2539:|DM5PR1201MB2539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2539EE3258CAF549EE34E4FD92340@DM5PR1201MB2539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(199004)(189003)(66946007)(66556008)(66476007)(26005)(31696002)(16576012)(6486002)(52116002)(316002)(36916002)(5660300002)(36756003)(31686004)(478600001)(2906002)(81156014)(81166006)(8676002)(2616005)(86362001)(53546011)(16526019)(44832011)(956004)(186003)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2539;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37oHv4wAxxlA/oV6BdOpGqudJaXBBalNwfc8YiKT4WCbd8pwJDbZCxJtrTyKRWQBsCVB+eH1vPJq7XQBXoEfG8KjgAExYkvM/c1TAh5IZo+hERWyJ2Upx2r1GNeIunqkI7QtXo/Fn4ILh7ERgrB4zZN/1Tjl/boTKLrqNTQ3vRwHQgWifJ2HOBFg5eovzwyXXm3mjsoSr+tiNYq5o86CI5rCHOR0QcvyEFGRcN6S1kvqos3Dh13mNNbcmsYgI4GsRkImtu2g3Tb+EqE5eGUlFvL/AKUtjEwDIP8T6UO8KL0m5tHK8DVQn8Q01VaBPWil7CHd60osrbL8exvsjD4bGKUXwUH8sAFdYmhqcuXTgaPlXX8OPIKdduI7QLRSfzygbpOW4tLMN0G1Pm+y+Dh6dbV+rvi6X3XmP2WyJrSTdlqkTNwM/lSHfXBM10GlqVdp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4eb1a0-9cb8-46b4-ca32-08d7988b04c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 00:45:14.5809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UI8Xkxhqx6OJxxiTS8zDklVakiuG5f2+cBdWrIm/AMhElrHsdI2G3ttrIFJ1WBQXqNb3Uvekg0zqNnJZc1rwFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2539
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

T24gMjAyMC0wMS0xMyAzOjI2IHAubS4sIEFsZXggU2llcnJhIHdyb3RlOgo+IHRsYnMgaW52YWxp
ZGF0ZSBwb2ludGVyIGZ1bmN0aW9uIGFkZGVkIHRvIGtpcV9wbTRfZnVuY3Mgc3RydWN0Lgo+IFRo
aXMgd2F5LCB0bGIgZmx1c2ggY2FuIGJlIGRvbmUgdGhyb3VnaCBraXEgbWVtYmVyLgo+IFRMQnMg
aW52YWxpZGF0YXRpb24gaW1wbGVtZW50ZWQgZm9yIGdmeDkgYW5kIGdmeDEwLgo+Cj4gQ2hhbmdl
LUlkOiBJMWI3N2IzNjRmM2FlMDAzOGZmM2U3MGU4NjliZTVmMmVmNmU2ZDI5Mwo+IFNpZ25lZC1v
ZmYtYnk6IEFsZXggU2llcnJhIDxhbGV4LnNpZXJyYUBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oIHwgIDQgKysrKwo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgIHwgMTUgKysrKysrKysrKysrKysrCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jICAgfCAxNCArKysrKysrKysrKysr
Kwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oCj4gaW5kZXggOGU4OGUwNDExNjYyLi5hZjRiZDI3OWY0
MmYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5o
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oCj4gQEAgLTc2
LDExICs3NiwxNSBAQCBzdHJ1Y3Qga2lxX3BtNF9mdW5jcyB7Cj4gICAJCQkJCXN0cnVjdCBhbWRn
cHVfcmluZyAqcmluZywKPiAgIAkJCQkJdTY0IGFkZHIsCj4gICAJCQkJCXU2NCBzZXEpOwo+ICsJ
dm9pZCAoKmtpcV9pbnZhbGlkYXRlX3RsYnMpKHN0cnVjdCBhbWRncHVfcmluZyAqa2lxX3Jpbmcs
Cj4gKwkJCQl1aW50MTZfdCBwYXNpZCwgdWludDMyX3QgZmx1c2hfdHlwZSwKPiArCQkJCWJvb2wg
YWxsX2h1Yik7Cj4gICAJLyogUGFja2V0IHNpemVzICovCj4gICAJaW50IHNldF9yZXNvdXJjZXNf
c2l6ZTsKPiAgIAlpbnQgbWFwX3F1ZXVlc19zaXplOwo+ICAgCWludCB1bm1hcF9xdWV1ZXNfc2l6
ZTsKPiAgIAlpbnQgcXVlcnlfc3RhdHVzX3NpemU7Cj4gKwlpbnQgaW52YWxpZGF0ZV90bGJzX3Np
emU7Cj4gICB9Owo+ICAgCj4gICBzdHJ1Y3QgYW1kZ3B1X2tpcSB7Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiBpbmRleCAzNzllNDZjMWI3ZjYuLmQ3MmI2MGY5OTdjOCAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gQEAgLTQwLDYgKzQw
LDcgQEAKPiAgICNpbmNsdWRlICJpdnNyY2lkL2dmeC9pcnFzcmNzX2dmeF8xMF8xLmgiCj4gICAK
PiAgICNpbmNsdWRlICJzb2MxNS5oIgo+ICsjaW5jbHVkZSAic29jMTVkLmgiCj4gICAjaW5jbHVk
ZSAic29jMTVfY29tbW9uLmgiCj4gICAjaW5jbHVkZSAiY2xlYXJzdGF0ZV9nZngxMC5oIgo+ICAg
I2luY2x1ZGUgInYxMF9zdHJ1Y3RzLmgiCj4gQEAgLTM0NiwxNSArMzQ3LDI5IEBAIHN0YXRpYyB2
b2lkIGdmeDEwX2tpcV9xdWVyeV9zdGF0dXMoc3RydWN0IGFtZGdwdV9yaW5nICpraXFfcmluZywK
PiAgIAlhbWRncHVfcmluZ193cml0ZShraXFfcmluZywgdXBwZXJfMzJfYml0cyhzZXEpKTsKPiAg
IH0KPiAgIAo+ICtzdGF0aWMgdm9pZCBnZngxMF9raXFfaW52YWxpZGF0ZV90bGJzKHN0cnVjdCBh
bWRncHVfcmluZyAqa2lxX3JpbmcsCj4gKwkJCQl1aW50MTZfdCBwYXNpZCwgdWludDMyX3QgZmx1
c2hfdHlwZSwKPiArCQkJCWJvb2wgYWxsX2h1YikKPiArewo+ICsJYW1kZ3B1X3Jpbmdfd3JpdGUo
a2lxX3JpbmcsIFBBQ0tFVDMoUEFDS0VUM19JTlZBTElEQVRFX1RMQlMsIDApKTsKPiArCWFtZGdw
dV9yaW5nX3dyaXRlKGtpcV9yaW5nLAo+ICsJCQlQQUNLRVQzX0lOVkFMSURBVEVfVExCU19EU1Rf
U0VMKDEpIHwKPiArCQkJUEFDS0VUM19JTlZBTElEQVRFX1RMQlNfQUxMX0hVQihhbGxfaHViKSB8
Cj4gKwkJCVBBQ0tFVDNfSU5WQUxJREFURV9UTEJTX1BBU0lEKHBhc2lkKSB8Cj4gKwkJCVBBQ0tF
VDNfSU5WQUxJREFURV9UTEJTX0ZMVVNIX1RZUEUoZmx1c2hfdHlwZSkpOwo+ICt9Cj4gKwo+ICAg
c3RhdGljIGNvbnN0IHN0cnVjdCBraXFfcG00X2Z1bmNzIGdmeF92MTBfMF9raXFfcG00X2Z1bmNz
ID0gewo+ICAgCS5raXFfc2V0X3Jlc291cmNlcyA9IGdmeDEwX2tpcV9zZXRfcmVzb3VyY2VzLAo+
ICAgCS5raXFfbWFwX3F1ZXVlcyA9IGdmeDEwX2tpcV9tYXBfcXVldWVzLAo+ICAgCS5raXFfdW5t
YXBfcXVldWVzID0gZ2Z4MTBfa2lxX3VubWFwX3F1ZXVlcywKPiAgIAkua2lxX3F1ZXJ5X3N0YXR1
cyA9IGdmeDEwX2tpcV9xdWVyeV9zdGF0dXMsCj4gKwkua2lxX2ludmFsaWRhdGVfdGxicyA9IGdm
eDEwX2tpcV9pbnZhbGlkYXRlX3RsYnMsCj4gICAJLnNldF9yZXNvdXJjZXNfc2l6ZSA9IDgsCj4g
ICAJLm1hcF9xdWV1ZXNfc2l6ZSA9IDcsCj4gICAJLnVubWFwX3F1ZXVlc19zaXplID0gNiwKPiAg
IAkucXVlcnlfc3RhdHVzX3NpemUgPSA3LAo+ICsJLmludmFsaWRhdGVfdGxic19zaXplID0gMTIs
CgpUaGlzIGxvb2tzIGxpa2UgaXQgd2FzIGNvcGllZCBmcm9tIHRoZSBmdW5jdGlvbiB0aGF0IGVt
aXRzIGJvdGggZmx1c2ggCmFuZCBmZW5jZS4gTm93IHRoYXQgdGhlIGZ1bmN0aW9uIG9ubHkgZW1p
dHMgdGhlIGZsdXNoLCB0aGlzIG51bWJlciAKc2hvdWxkIGJlIHNtYWxsZXIuIE9ubHkgMiBkd29y
ZHMuIEFuZCBpdCBzZWVtcyBsaWtlIDEyIHdhcyAKb3Zlci1lc3RpbWF0ZWQsIGJlY2F1c2UgdGhl
IGZlbmNlIGlzIG9ubHkgOCBkd29yZHMuCgpSZWdhcmRzLAogwqAgRmVsaXgKCgo+ICAgfTsKPiAg
IAo+ICAgc3RhdGljIHZvaWQgZ2Z4X3YxMF8wX3NldF9raXFfcG00X2Z1bmNzKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+IGlu
ZGV4IGFkMDE3OWVhMmNjNS4uYjg3NTkzODZkY2JiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jCj4gQEAgLTgzNywxNSArODM3LDI5IEBAIHN0YXRpYyB2b2lkIGdmeF92
OV8wX2tpcV9xdWVyeV9zdGF0dXMoc3RydWN0IGFtZGdwdV9yaW5nICpraXFfcmluZywKPiAgIAlh
bWRncHVfcmluZ193cml0ZShraXFfcmluZywgdXBwZXJfMzJfYml0cyhzZXEpKTsKPiAgIH0KPiAg
IAo+ICtzdGF0aWMgdm9pZCBnZnhfdjlfMF9raXFfaW52YWxpZGF0ZV90bGJzKHN0cnVjdCBhbWRn
cHVfcmluZyAqa2lxX3JpbmcsCj4gKwkJCQl1aW50MTZfdCBwYXNpZCwgdWludDMyX3QgZmx1c2hf
dHlwZSwKPiArCQkJCWJvb2wgYWxsX2h1YikKPiArewo+ICsJYW1kZ3B1X3Jpbmdfd3JpdGUoa2lx
X3JpbmcsIFBBQ0tFVDMoUEFDS0VUM19JTlZBTElEQVRFX1RMQlMsIDApKTsKPiArCWFtZGdwdV9y
aW5nX3dyaXRlKGtpcV9yaW5nLAo+ICsJCQlQQUNLRVQzX0lOVkFMSURBVEVfVExCU19EU1RfU0VM
KDEpIHwKPiArCQkJUEFDS0VUM19JTlZBTElEQVRFX1RMQlNfQUxMX0hVQihhbGxfaHViKSB8Cj4g
KwkJCVBBQ0tFVDNfSU5WQUxJREFURV9UTEJTX1BBU0lEKHBhc2lkKSB8Cj4gKwkJCVBBQ0tFVDNf
SU5WQUxJREFURV9UTEJTX0ZMVVNIX1RZUEUoZmx1c2hfdHlwZSkpOwo+ICt9Cj4gKwo+ICAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBraXFfcG00X2Z1bmNzIGdmeF92OV8wX2tpcV9wbTRfZnVuY3MgPSB7
Cj4gICAJLmtpcV9zZXRfcmVzb3VyY2VzID0gZ2Z4X3Y5XzBfa2lxX3NldF9yZXNvdXJjZXMsCj4g
ICAJLmtpcV9tYXBfcXVldWVzID0gZ2Z4X3Y5XzBfa2lxX21hcF9xdWV1ZXMsCj4gICAJLmtpcV91
bm1hcF9xdWV1ZXMgPSBnZnhfdjlfMF9raXFfdW5tYXBfcXVldWVzLAo+ICAgCS5raXFfcXVlcnlf
c3RhdHVzID0gZ2Z4X3Y5XzBfa2lxX3F1ZXJ5X3N0YXR1cywKPiArCS5raXFfaW52YWxpZGF0ZV90
bGJzID0gZ2Z4X3Y5XzBfa2lxX2ludmFsaWRhdGVfdGxicywKPiAgIAkuc2V0X3Jlc291cmNlc19z
aXplID0gOCwKPiAgIAkubWFwX3F1ZXVlc19zaXplID0gNywKPiAgIAkudW5tYXBfcXVldWVzX3Np
emUgPSA2LAo+ICAgCS5xdWVyeV9zdGF0dXNfc2l6ZSA9IDcsCj4gKwkuaW52YWxpZGF0ZV90bGJz
X3NpemUgPSAxMiwKPiAgIH07Cj4gICAKPiAgIHN0YXRpYyB2b2lkIGdmeF92OV8wX3NldF9raXFf
cG00X2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
