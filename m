Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D471C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 18:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230C220714
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 18:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nc0wsiyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230C220714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE74D891DC;
	Thu, 26 Mar 2020 18:46:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C1186E90D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 18:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4q4uPgifutCmsoi86MakGFUhmA/gAkvag4y8yWjDS0+Jlajb9WRMbnUCNLj3UjZXdva58xUYQeDBCpQbwR8M/S/9GHU4wnlTQvq20pAZwxD+lLO3Pyeu+98IP2Xus3MXVC7s/RsHBANLwEKVoaAaVPUC3JWqtF7kTlVJ17a/jnaQ/ROPl2uZ8ziW+nAJgMotztZPUdygdYuDIhdfdDr5gFlbQXa6F5q9CRWgj8KlAcm7cTtecf5s/L11a1SVHAg8KHk4sTePk4wd0tT1eqfGKRyEkg5C/dVPwIMZQcSkJ6joeAaJGV7Npv3n46rDrQjw9wmiptPuIibhoSYkaeRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DdHx8ciKNL2viBkgtw6E7WpnvTta8ueadC1ZiN9kEA=;
 b=ZalZoUcww+lTWBq/n+zbTUoMzgGejBmeVVcVgSiNVnWI1UboEeqlFnKbifHL64HwN1VxiMFdVp+QMkaS7hYazFSo5006P25eCf8sC5ztsnLnQpm/Dsn8nlbVVB647JcGQJ5TkyyBEkPHhuXCyMxmvfKiGNc7v9qrpUxys96heZMRTb/GLl7XlfnXnaxcQh0wvjD81YzAaj64ismAdRrUHJOtCQg7AWd7Uz2hCKa/JkS9EaOPQWHSv2fhUIK392XdHoFnTZztXRN4ZzCiShCicvpG36nfd+SLRrY43YyB0xFuUrU2+d58RWcKIYPYKypkxmh28NosUXZ3G0zdYDpKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DdHx8ciKNL2viBkgtw6E7WpnvTta8ueadC1ZiN9kEA=;
 b=Nc0wsiyiMHsNK9Qsv44+xEyU/0U2IbIIg4HtjTLI739P6K0POsKGnnWUfg8pUAylXSJdTPLyxc63EY7rc1vik8DsVzZuRDRbUWl0FywBDg1N2eLBenB3lyObdXHL+S5Y9HhwOYGYI38ctkJ1ZZ4BaTKNome6mwU/w7vM0f2boGY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2462.namprd12.prod.outlook.com (2603:10b6:802:28::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Thu, 26 Mar
 2020 18:46:10 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2835.021; Thu, 26 Mar 2020
 18:46:10 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu: replace ih ip block for vega20 and
 arcturus
To: amd-gfx@lists.freedesktop.org,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
References: <20200324215749.29169-1-alex.sierra@amd.com>
 <20200324215749.29169-4-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <10cf73d2-e364-7e9e-3543-4bfc5b474bbe@amd.com>
Date: Thu, 26 Mar 2020 14:46:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200324215749.29169-4-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47)
 To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.147.81] (165.204.55.211) by
 YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 18:46:09 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9dc877a9-fd01-4828-e67e-08d7d1b5f36c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2462:|SN1PR12MB2462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB246227FDDAA2C4AECA6699D092CF0@SN1PR12MB2462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(6862004)(8676002)(36756003)(53546011)(316002)(6486002)(66946007)(66476007)(66556008)(478600001)(16576012)(31686004)(37006003)(5660300002)(2906002)(16526019)(52116002)(86362001)(26005)(81156014)(8936002)(2616005)(44832011)(956004)(6636002)(31696002)(186003)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2462;
 H:SN1PR12MB2414.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgMQqqAJNPtlRP53XeZaifXNTNwSDnpXuKU4JG7RLEvjDE0r5/Rin1gOYoBS0oTDIrvglt6VJZJ9qQVY8mEqpQzCkYbWoxNS4IqqgEUHlgDXKT0A4oLVtx4Z5MO2QVuBlLX3DDGxI/pXKio91xnxka4IxgdQrxsB1YVeGKdxJrWmr6qcgNsTPTINaOzzF8zDBF7AKETNJsZBB/gQy/HstpmM1t9hax+6U9KBSOmFMNYAbKmiNbMAiNHqor7YBzz1vXD06Kg918tfJ6qxhTcoEP2XRVOpQEgbmc2MRSBQuUAngHXorxwnLgqDMmfa5rFIIO1CRBX5njvDhxauyVlqrJwUBc7jKuG632WMEGjAixARlBVAkRI+mG/X+X/1X3/12Yk2HMT39UdcINvokxgFjSQdMHNASzxV0vme5CCctkGg7kYfBuHEqBzNeEjeCrXp
X-MS-Exchange-AntiSpam-MessageData: aIfWsT++XPLW3upVQ6vswmgiwnwdt8MEZJoSnxvOcSteMi1Jp3TJVb7j2hkqMsq9/j1Wr/lMccA+VONd52fRu+A6cUhW0V/CtSp2W6YcXZWd672gnAh7o73P3RzY4BN8IiffG60xEUncCqfGFwuRwQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc877a9-fd01-4828-e67e-08d7d1b5f36c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 18:46:10.1539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTWNoyA3YwDMXrD634L9U6Q6yd3KqUPskiknYiASpidS5H0KGPR6Sg2qjYUc7l21wR0RSFoxJae6mteV5lLk4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2462
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

VGhpcyBjaGFuZ2Ugc2VlbXMgdG8gYnJlYWsgdGhlIHNlcXVlbmNlIG9mIElQIGJsb2NrIGluaXRp
YWxpemF0aW9uIHRoYXQgCmlzIHNwZWNpYWwgZm9yIFNSSU9WLiBJcyB5b3VyIGludGVudGlvbiB0
byB1c2UgdGhlIFNSSU9WIHNlcXVlbmNlIGZvciAKYmFyZSBtZXRhbCBhcyB3ZWxsPyBUaGF0IHdv
dWxkIGJlIGdvb2QgZm9yIHNpbXBsaWZ5aW5nIHRoZSBjb2RlIGJ1dCB0aGVuIAp0aGF0IHNob3Vs
ZCBiZSBzdGF0ZWQgaW4gdGhlIGNvbW1pdCBkZXNjcmlwdGlvbiwgb3IgZXZlbiBiZSBkb25lIGFz
IGEgCnNlcGFyYXRlIGNvbW1pdC4KClNlZSB0aGlzIGNvbW1pdCBmb3IgcmVmZXJlbmNlOgoKY29t
bWl0IDJkMTFmZDNmNTQyMGY3MWIxNTE1ODY3MmE4ZmZhMzcyMmIzN2ViZjUKQXV0aG9yOiBUcmln
Z2VyIEh1YW5nIDxUcmlnZ2VyLkh1YW5nQGFtZC5jb20+CkRhdGU6wqDCoCBXZWQgQXByIDI0IDE1
OjIzOjQxIDIwMTkgKzA4MDAKCiDCoMKgwqAgZHJtL2FtZGdwdTogaW5pdGlhbGl6ZSBQU1AgYmVm
b3JlIElIIHVuZGVyIFNSLUlPVgoKIMKgwqDCoCBJbiBvcmRlciB0byBzdXBwb3J0IG5ldyBQU1Ag
ZmVhdHVyZSB0aGF0IFBTUCBtYXkgcHJvdmlkZSBpbnRlcmZhY2UKIMKgwqDCoCB0byBwcm9ncmFt
IElIIENOVEwgcmVnaXN0ZXIsIGluaXRpYWxpemUgUFNQIGJlZm9yZSBJSCB1bmRlciBWZWdhMTAK
IMKgwqDCoCBTUi1JT1YgVkYKCiDCoMKgwqAgU2lnbmVkLW9mZi1ieTogVHJpZ2dlciBIdWFuZyA8
VHJpZ2dlci5IdWFuZ0BhbWQuY29tPgogwqDCoMKgIFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CiDCoMKgwqAgU2lnbmVkLW9mZi1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKUmVnYXJkcywKIMKgIEZlbGl4CgpP
biAyMDIwLTAzLTI0IDE3OjU3LCBBbGV4IFNpZXJyYSB3cm90ZToKPiBbV2h5XQo+IFZlZ2EyMCBh
bmQgQXJjdHVydXMgYXNpY3MgdXNlIG9zcyA1LjAgdmVyc2lvbi4KPgo+IFtIb3ddCj4gUmVwbGFj
ZSBpaCBpcCBibG9jayBieSBuYXZpMTAgZm9yIHZlZ2EyMCBhbmQgYXJjdHVydXMuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4KPiAtLS0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCAxMSArKysrKystLS0tLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc29jMTUuYwo+IGluZGV4IGFhZjAyZGJiMDNmNy4uYTM4YjVhOTBjZDFjIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCj4gQEAgLTYyLDYgKzYyLDcgQEAKPiAg
ICNpbmNsdWRlICJuYmlvX3Y3XzAuaCIKPiAgICNpbmNsdWRlICJuYmlvX3Y3XzQuaCIKPiAgICNp
bmNsdWRlICJ2ZWdhMTBfaWguaCIKPiArI2luY2x1ZGUgIm5hdmkxMF9paC5oIgo+ICAgI2luY2x1
ZGUgInNkbWFfdjRfMC5oIgo+ICAgI2luY2x1ZGUgInV2ZF92N18wLmgiCj4gICAjaW5jbHVkZSAi
dmNlX3Y0XzAuaCIKPiBAQCAtNzMyLDkgKzczMyw3IEBAIGludCBzb2MxNV9zZXRfaXBfYmxvY2tz
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCQkJCWVsc2UKPiAgIAkJCQkJYW1kZ3B1
X2RldmljZV9pcF9ibG9ja19hZGQoYWRldiwgJnBzcF92M18xX2lwX2Jsb2NrKTsKPiAgIAkJCX0K
PiAtCQkJYW1kZ3B1X2RldmljZV9pcF9ibG9ja19hZGQoYWRldiwgJnZlZ2ExMF9paF9pcF9ibG9j
ayk7Cj4gICAJCX0gZWxzZSB7Cj4gLQkJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfYWRkKGFkZXYs
ICZ2ZWdhMTBfaWhfaXBfYmxvY2spOwo+ICAgCQkJaWYgKGxpa2VseShhZGV2LT5maXJtd2FyZS5s
b2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfUFNQKSkgewo+ICAgCQkJCWlmIChhZGV2LT5hc2lj
X3R5cGUgPT0gQ0hJUF9WRUdBMjApCj4gICAJCQkJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfYWRk
KGFkZXYsICZwc3BfdjExXzBfaXBfYmxvY2spOwo+IEBAIC03NDIsNiArNzQxLDEwIEBAIGludCBz
b2MxNV9zZXRfaXBfYmxvY2tzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCQkJCQlh
bWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmcHNwX3YzXzFfaXBfYmxvY2spOwo+ICAg
CQkJfQo+ICAgCQl9Cj4gKwkJaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0EyMCkKPiAr
CQkJYW1kZ3B1X2RldmljZV9pcF9ibG9ja19hZGQoYWRldiwgJm5hdmkxMF9paF9pcF9ibG9jayk7
Cj4gKwkJZWxzZQo+ICsJCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmdmVnYTEw
X2loX2lwX2Jsb2NrKTsKPiAgIAkJYW1kZ3B1X2RldmljZV9pcF9ibG9ja19hZGQoYWRldiwgJmdm
eF92OV8wX2lwX2Jsb2NrKTsKPiAgIAkJYW1kZ3B1X2RldmljZV9pcF9ibG9ja19hZGQoYWRldiwg
JnNkbWFfdjRfMF9pcF9ibG9jayk7Cj4gICAJCWlmIChpc19zdXBwb3J0X3N3X3NtdShhZGV2KSkg
ewo+IEBAIC03ODUsMTMgKzc4OCwxMSBAQCBpbnQgc29jMTVfc2V0X2lwX2Jsb2NrcyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAkJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgewo+
ICAgCQkJaWYgKGxpa2VseShhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xP
QURfUFNQKSkKPiAgIAkJCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmcHNwX3Yx
MV8wX2lwX2Jsb2NrKTsKPiAtCQkJYW1kZ3B1X2RldmljZV9pcF9ibG9ja19hZGQoYWRldiwgJnZl
Z2ExMF9paF9pcF9ibG9jayk7Cj4gICAJCX0gZWxzZSB7Cj4gLQkJCWFtZGdwdV9kZXZpY2VfaXBf
YmxvY2tfYWRkKGFkZXYsICZ2ZWdhMTBfaWhfaXBfYmxvY2spOwo+ICAgCQkJaWYgKGxpa2VseShh
ZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfUFNQKSkKPiAgIAkJCQlh
bWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmcHNwX3YxMV8wX2lwX2Jsb2NrKTsKPiAg
IAkJfQo+IC0KPiArCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmbmF2aTEwX2lo
X2lwX2Jsb2NrKTsKPiAgIAkJaWYgKGFkZXYtPmVuYWJsZV92aXJ0dWFsX2Rpc3BsYXkgfHwgYW1k
Z3B1X3NyaW92X3ZmKGFkZXYpKQo+ICAgCQkJYW1kZ3B1X2RldmljZV9pcF9ibG9ja19hZGQoYWRl
diwgJmRjZV92aXJ0dWFsX2lwX2Jsb2NrKTsKPiAgIAkJYW1kZ3B1X2RldmljZV9pcF9ibG9ja19h
ZGQoYWRldiwgJmdmeF92OV8wX2lwX2Jsb2NrKTsKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
