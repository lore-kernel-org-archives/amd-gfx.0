Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9489C33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 16:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFB421569
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 16:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ee5enWYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFB421569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A956E039;
	Mon, 13 Jan 2020 16:36:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEE426E039
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 16:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDw5NiefEF2ETcpMaqGK6BySKgCE1nwPSj92ZUnN94dfdB2eAqeW8wf+KASljHkOLB4ZEJYthwxX4oCqzi5xCqbjDE2NDYCsRrE/9NWysyzaHDjEgb79JOmhqY8PZcxP5nWvZb/79+U6eNywSeTTd1q0QvroXTA181qagpyn/MjESdQLiB5u7j2nS5cHaCQt2DSRheqGi6/8ejj0GHJ+A8ZTRqwn76HHoS8MnkN306dDtr+sTUzdPYefudytXhNkk0Uefg0rr3UCvCudoEzI2J4zE4gpLplboIDTk0o7+BhfgSnn2QC5N7wsPhhu+/3GDE9Z+yio8DfSGvn8Y4lWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL3Pc0Ar6VrKU9LapujShD5pty85quVL5xZI3LaFWjI=;
 b=UE4+UWmfR4HMwqLJOwYczBbS/U47kHM6ZM7gyHFSbArGGKdE4wTjoAFXX+JuX6GFEZz6JTcKn78GzF0egD1qys72ecOBfgXzKgIaaEJKv54CSE+Q1gg9zZp18JnNT1jARWeA7gMFO3WG8FvJfDDt1XJzRoprOCUTnLupDFOKMIDEAXBWNRm9WmrscJ7tZSyfrVHwF7mnjv4tODGDbTrgtPwFhfQVfGMMcrDcHUpO87L/JenYZELn/b8CypArtan2HZXNgEbQo1gXSW2QPjtli26gz3EY8Fe+vhnUX8gMe2S/Hl/TKmxDgmyZW0xwF2d8C3fuleRyEjlKE27RSNzhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL3Pc0Ar6VrKU9LapujShD5pty85quVL5xZI3LaFWjI=;
 b=ee5enWYjILfKGlpukkoHTqKMK1Sx48yFKix3Ssc/nqX1ABAa+WAjLgEpa13X41teOfjE3JKX4RWIdxRAbW9EiueNYuLeTvnCG7u6QnaXx1ag5CmRCo4LlbwVNIhewUjaNpRIMuNtvub3YWqMqkw0Iw/gNkVSB0kiwmqT/yv3kTw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0026.namprd12.prod.outlook.com (10.174.105.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Mon, 13 Jan 2020 16:36:55 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 16:36:55 +0000
Subject: Re: [PATCH 3/7] drm/amdgpu: implement tlbs invalidate on gfx9 gfx10
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200111183938.126310-1-alex.sierra@amd.com>
 <20200111183938.126310-3-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <1700a423-fdfb-c4d4-1ea3-671b36a4d33f@amd.com>
Date: Mon, 13 Jan 2020 11:36:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200111183938.126310-3-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 16:36:55 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb623fac-2549-4112-a0d2-08d79846cd2a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0026:|DM5PR1201MB0026:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0026EEF455D6040F571411B392350@DM5PR1201MB0026.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(199004)(189003)(8676002)(16576012)(316002)(44832011)(66946007)(81156014)(81166006)(66556008)(86362001)(5660300002)(478600001)(2906002)(6486002)(66476007)(53546011)(36916002)(956004)(31696002)(8936002)(16526019)(26005)(31686004)(186003)(36756003)(2616005)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0026;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxZTaf6NuAIfgTcU0GzTq9GO3ongvaUJZ7RLaQ7oCCawuI48Fp+JIlPHOxMv1Gd3hHDdB/ogkxn3j0Eybe6UQa1zRSPDYsLsktYgoOaPuhec7/xmyZvdTQzMnPLaFK/3QY18sars0Fqm5EgcyTuLc6CUxGT1VIu9V36gp8puaXSHMPGV33exxhLQem/HUkHeOgetbnBY02mDKHDnjKGIvqB9KmTEehCNl27z+fqXddVb9xJzg1KzdsGgJ5EMHJgqXoXDU4xh7ubQIyJ5Fch0Zyh/BEYCUHXX/4qyiJhvMvjO78CEkSpTeYAfwNnQlAk46/8vp/8G5Mvz9uAWNrQXYLd5mzIYg+OXZWJFkNEh3/gNDycRm8dQeI2eI9ImI6ute1/yVyjz4WabluL07gJAi7HETSqyFqJoItpyXsFYLkm2+jYO3T/H9gnUNnaXIRMq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb623fac-2549-4112-a0d2-08d79846cd2a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 16:36:55.7708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLR0Q/E1BzdvGPyKEb50LOdK3qe9KUis/F1ppUMmYJlRDku4K9w9vMBmPM+vCAy9qE0dlFxWfPl1V8ggUoIZLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0026
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

T24gMjAyMC0wMS0xMSAxOjM5IHAubS4sIEFsZXggU2llcnJhIHdyb3RlOgo+IHRsYnMgaW52YWxp
ZGF0ZSBwb2ludGVyIGZ1bmN0aW9uIGFkZGVkIHRvIGtpcV9wbTRfZnVuY3Mgc3RydWN0Lgo+IFRo
aXMgd2F5LCB0bGIgZmx1c2ggY2FuIGJlIGRvbmUgdGhyb3VnaCBraXEgbWVtYmVyLgo+IFRMQnMg
aW52YWxpZGF0YXRpb24gaW1wbGVtZW50ZWQgZm9yIGdmeDkgYW5kIGdmeDEwLgo+Cj4gQ2hhbmdl
LUlkOiBJMWI3N2IzNjRmM2FlMDAzOGZmM2U3MGU4NjliZTVmMmVmNmU2ZDI5Mwo+IFNpZ25lZC1v
ZmYtYnk6IEFsZXggU2llcnJhIDxhbGV4LnNpZXJyYUBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oIHwgIDQgKysrCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyAgfCAzMyArKysrKysrKysrKysrKysrKysrKysr
KysrCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jICAgfCAzMiArKysr
KysrKysrKysrKysrKysrKysrKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygr
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZngu
aCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaAo+IGluZGV4IDhlODhl
MDQxMTY2Mi4uMjkyNzgzN2JkNDAxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZnguaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nZnguaAo+IEBAIC03NiwxMSArNzYsMTUgQEAgc3RydWN0IGtpcV9wbTRfZnVuY3Mgewo+
ICAgCQkJCQlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCj4gICAJCQkJCXU2NCBhZGRyLAo+ICAg
CQkJCQl1NjQgc2VxKTsKPiArCWludCAoKmtpcV9pbnZhbGlkYXRlX3RsYnMpKHN0cnVjdCBhbWRn
cHVfcmluZyAqa2lxX3JpbmcsCj4gKwkJCQl1aW50MTZfdCBwYXNpZCwgdWludDMyX3QgZmx1c2hf
dHlwZSwKPiArCQkJCWJvb2wgYWxsX2h1Yik7Cj4gICAJLyogUGFja2V0IHNpemVzICovCj4gICAJ
aW50IHNldF9yZXNvdXJjZXNfc2l6ZTsKPiAgIAlpbnQgbWFwX3F1ZXVlc19zaXplOwo+ICAgCWlu
dCB1bm1hcF9xdWV1ZXNfc2l6ZTsKPiAgIAlpbnQgcXVlcnlfc3RhdHVzX3NpemU7Cj4gKwlpbnQg
aW52YWxpZGF0ZV90bGJzX3NpemU7Cj4gICB9Owo+ICAgCj4gICBzdHJ1Y3QgYW1kZ3B1X2tpcSB7
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiBpbmRleCAzNzllNDZjMWI3
ZjYuLjJlODIyMTNmNTdlYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjEwXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBf
MC5jCj4gQEAgLTQwLDYgKzQwLDcgQEAKPiAgICNpbmNsdWRlICJpdnNyY2lkL2dmeC9pcnFzcmNz
X2dmeF8xMF8xLmgiCj4gICAKPiAgICNpbmNsdWRlICJzb2MxNS5oIgo+ICsjaW5jbHVkZSAic29j
MTVkLmgiCj4gICAjaW5jbHVkZSAic29jMTVfY29tbW9uLmgiCj4gICAjaW5jbHVkZSAiY2xlYXJz
dGF0ZV9nZngxMC5oIgo+ICAgI2luY2x1ZGUgInYxMF9zdHJ1Y3RzLmgiCj4gQEAgLTM0NiwxNSAr
MzQ3LDQ3IEBAIHN0YXRpYyB2b2lkIGdmeDEwX2tpcV9xdWVyeV9zdGF0dXMoc3RydWN0IGFtZGdw
dV9yaW5nICpraXFfcmluZywKPiAgIAlhbWRncHVfcmluZ193cml0ZShraXFfcmluZywgdXBwZXJf
MzJfYml0cyhzZXEpKTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IGdmeDEwX2tpcV9pbnZhbGlk
YXRlX3RsYnMoc3RydWN0IGFtZGdwdV9yaW5nICpraXFfcmluZywKPiArCQkJCXVpbnQxNl90IHBh
c2lkLCB1aW50MzJfdCBmbHVzaF90eXBlLAo+ICsJCQkJYm9vbCBhbGxfaHViKQo+ICt7Cj4gKwlz
aWduZWQgbG9uZyByOwo+ICsJdWludDMyX3Qgc2VxOwo+ICsJc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYgPSBraXFfcmluZy0+YWRldjsKPiArCXN0cnVjdCBhbWRncHVfa2lxICpraXEgPSAmYWRl
di0+Z2Z4LmtpcTsKPiArCj4gKwlzcGluX2xvY2soJmFkZXYtPmdmeC5raXEucmluZ19sb2NrKTsK
PiArCWFtZGdwdV9yaW5nX2FsbG9jKGtpcV9yaW5nLCBraXEtPnBtZi0+aW52YWxpZGF0ZV90bGJz
X3NpemUpOwo+ICsJYW1kZ3B1X3Jpbmdfd3JpdGUoa2lxX3JpbmcsIFBBQ0tFVDMoUEFDS0VUM19J
TlZBTElEQVRFX1RMQlMsIDApKTsKPiArCWFtZGdwdV9yaW5nX3dyaXRlKGtpcV9yaW5nLAo+ICsJ
CQlQQUNLRVQzX0lOVkFMSURBVEVfVExCU19EU1RfU0VMKDEpIHwKPiArCQkJUEFDS0VUM19JTlZB
TElEQVRFX1RMQlNfQUxMX0hVQihhbGxfaHViKSB8Cj4gKwkJCVBBQ0tFVDNfSU5WQUxJREFURV9U
TEJTX1BBU0lEKHBhc2lkKSB8Cj4gKwkJCVBBQ0tFVDNfSU5WQUxJREFURV9UTEJTX0ZMVVNIX1RZ
UEUoZmx1c2hfdHlwZSkpOwo+ICsJYW1kZ3B1X2ZlbmNlX2VtaXRfcG9sbGluZyhraXFfcmluZywg
JnNlcSk7Cj4gKwlhbWRncHVfcmluZ19jb21taXQoa2lxX3JpbmcpOwo+ICsJc3Bpbl91bmxvY2so
JmFkZXYtPmdmeC5raXEucmluZ19sb2NrKTsKClRoZSBvdGhlciBLSVEgZnVuY3Rpb25zIGRvbid0
IGluY2x1ZGUgdGhlIGVtaXRfcG9sbGluZywgY29tbWl0IGFuZCAKbG9ja2luZy4gSSB0aGluayB0
aGUgd2F5IHRoZSBLSVEtZnVuY3MgaW50ZXJmYWNlIGlzIG1lYW50IHRvIGJlIHVzZWQsIAphbGwg
dGhhdCBzaG91bGQgYmUgb3V0c2lkZSB0aGUgSVAtdmVyc2lvbi1zcGVjaWZpYyBmdW5jdGlvbnMu
IEZvciAKY29uc2lzdGVuY3kgYWxsIHlvdSBzaG91bGQgZG8gaGVyZSBpcyB0aGUgYW1kZ3B1X3Jp
bmdfd3JpdGUgY2FsbHMgd2l0aCAKSVAtdmVyc2lvbi1zcGVjaWZpYyBwYWNrZXRzLgoKUmVnYXJk
cywKIMKgIEZlbGl4CgoKPiArCj4gKwlyID0gYW1kZ3B1X2ZlbmNlX3dhaXRfcG9sbGluZyhraXFf
cmluZywgc2VxLCBhZGV2LT51c2VjX3RpbWVvdXQpOwo+ICsJaWYgKHIgPCAxKSB7Cj4gKwkJRFJN
X0VSUk9SKCJ3YWl0IGZvciBraXEgZmVuY2UgZXJyb3I6ICVsZC5cbiIsIHIpOwo+ICsJCXJldHVy
biAtRVRJTUU7Cj4gKwl9Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30KPiArCj4gICBzdGF0aWMgY29u
c3Qgc3RydWN0IGtpcV9wbTRfZnVuY3MgZ2Z4X3YxMF8wX2tpcV9wbTRfZnVuY3MgPSB7Cj4gICAJ
LmtpcV9zZXRfcmVzb3VyY2VzID0gZ2Z4MTBfa2lxX3NldF9yZXNvdXJjZXMsCj4gICAJLmtpcV9t
YXBfcXVldWVzID0gZ2Z4MTBfa2lxX21hcF9xdWV1ZXMsCj4gICAJLmtpcV91bm1hcF9xdWV1ZXMg
PSBnZngxMF9raXFfdW5tYXBfcXVldWVzLAo+ICAgCS5raXFfcXVlcnlfc3RhdHVzID0gZ2Z4MTBf
a2lxX3F1ZXJ5X3N0YXR1cywKPiArCS5raXFfaW52YWxpZGF0ZV90bGJzID0gZ2Z4MTBfa2lxX2lu
dmFsaWRhdGVfdGxicywKPiAgIAkuc2V0X3Jlc291cmNlc19zaXplID0gOCwKPiAgIAkubWFwX3F1
ZXVlc19zaXplID0gNywKPiAgIAkudW5tYXBfcXVldWVzX3NpemUgPSA2LAo+ICAgCS5xdWVyeV9z
dGF0dXNfc2l6ZSA9IDcsCj4gKwkuaW52YWxpZGF0ZV90bGJzX3NpemUgPSAxMiwKPiAgIH07Cj4g
ICAKPiAgIHN0YXRpYyB2b2lkIGdmeF92MTBfMF9zZXRfa2lxX3BtNF9mdW5jcyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiBp
bmRleCBhZDAxNzllYTJjYzUuLjViZTZmYWI1NWI3MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYwo+IEBAIC04MzcsMTUgKzgzNyw0NyBAQCBzdGF0aWMgdm9pZCBnZnhf
djlfMF9raXFfcXVlcnlfc3RhdHVzKHN0cnVjdCBhbWRncHVfcmluZyAqa2lxX3JpbmcsCj4gICAJ
YW1kZ3B1X3Jpbmdfd3JpdGUoa2lxX3JpbmcsIHVwcGVyXzMyX2JpdHMoc2VxKSk7Cj4gICB9Cj4g
ICAKPiArc3RhdGljIGludCBnZnhfdjlfMF9raXFfaW52YWxpZGF0ZV90bGJzKHN0cnVjdCBhbWRn
cHVfcmluZyAqa2lxX3JpbmcsCj4gKwkJCQl1aW50MTZfdCBwYXNpZCwgdWludDMyX3QgZmx1c2hf
dHlwZSwKPiArCQkJCWJvb2wgYWxsX2h1YikKPiArewo+ICsJc2lnbmVkIGxvbmcgcjsKPiArCXVp
bnQzMl90IHNlcTsKPiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0ga2lxX3JpbmctPmFk
ZXY7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2tpcSAqa2lxID0gJmFkZXYtPmdmeC5raXE7Cj4gKwo+ICsJ
c3Bpbl9sb2NrKCZhZGV2LT5nZngua2lxLnJpbmdfbG9jayk7Cj4gKwlhbWRncHVfcmluZ19hbGxv
YyhraXFfcmluZywga2lxLT5wbWYtPmludmFsaWRhdGVfdGxic19zaXplKTsKPiArCWFtZGdwdV9y
aW5nX3dyaXRlKGtpcV9yaW5nLCBQQUNLRVQzKFBBQ0tFVDNfSU5WQUxJREFURV9UTEJTLCAwKSk7
Cj4gKwlhbWRncHVfcmluZ193cml0ZShraXFfcmluZywKPiArCQkJUEFDS0VUM19JTlZBTElEQVRF
X1RMQlNfRFNUX1NFTCgxKSB8Cj4gKwkJCVBBQ0tFVDNfSU5WQUxJREFURV9UTEJTX0FMTF9IVUIo
YWxsX2h1YikgfAo+ICsJCQlQQUNLRVQzX0lOVkFMSURBVEVfVExCU19QQVNJRChwYXNpZCkgfAo+
ICsJCQlQQUNLRVQzX0lOVkFMSURBVEVfVExCU19GTFVTSF9UWVBFKGZsdXNoX3R5cGUpKTsKPiAr
CWFtZGdwdV9mZW5jZV9lbWl0X3BvbGxpbmcoa2lxX3JpbmcsICZzZXEpOwo+ICsJYW1kZ3B1X3Jp
bmdfY29tbWl0KGtpcV9yaW5nKTsKPiArCXNwaW5fdW5sb2NrKCZhZGV2LT5nZngua2lxLnJpbmdf
bG9jayk7Cj4gKwo+ICsJciA9IGFtZGdwdV9mZW5jZV93YWl0X3BvbGxpbmcoa2lxX3JpbmcsIHNl
cSwgYWRldi0+dXNlY190aW1lb3V0KTsKPiArCWlmIChyIDwgMSkgewo+ICsJCURSTV9FUlJPUigi
d2FpdCBmb3Iga2lxIGZlbmNlIGVycm9yOiAlbGQuXG4iLCByKTsKPiArCQlyZXR1cm4gLUVUSU1F
Owo+ICsJfQo+ICsKPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICAgc3RhdGljIGNvbnN0IHN0cnVj
dCBraXFfcG00X2Z1bmNzIGdmeF92OV8wX2tpcV9wbTRfZnVuY3MgPSB7Cj4gICAJLmtpcV9zZXRf
cmVzb3VyY2VzID0gZ2Z4X3Y5XzBfa2lxX3NldF9yZXNvdXJjZXMsCj4gICAJLmtpcV9tYXBfcXVl
dWVzID0gZ2Z4X3Y5XzBfa2lxX21hcF9xdWV1ZXMsCj4gICAJLmtpcV91bm1hcF9xdWV1ZXMgPSBn
ZnhfdjlfMF9raXFfdW5tYXBfcXVldWVzLAo+ICAgCS5raXFfcXVlcnlfc3RhdHVzID0gZ2Z4X3Y5
XzBfa2lxX3F1ZXJ5X3N0YXR1cywKPiArCS5raXFfaW52YWxpZGF0ZV90bGJzID0gZ2Z4X3Y5XzBf
a2lxX2ludmFsaWRhdGVfdGxicywKPiAgIAkuc2V0X3Jlc291cmNlc19zaXplID0gOCwKPiAgIAku
bWFwX3F1ZXVlc19zaXplID0gNywKPiAgIAkudW5tYXBfcXVldWVzX3NpemUgPSA2LAo+ICAgCS5x
dWVyeV9zdGF0dXNfc2l6ZSA9IDcsCj4gKwkuaW52YWxpZGF0ZV90bGJzX3NpemUgPSAxMiwKPiAg
IH07Cj4gICAKPiAgIHN0YXRpYyB2b2lkIGdmeF92OV8wX3NldF9raXFfcG00X2Z1bmNzKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
