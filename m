Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6BFC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 02:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF71223D8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 02:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF71223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E098D6E9B6;
	Wed, 20 Nov 2019 02:00:15 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760079.outbound.protection.outlook.com [40.107.76.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0375B6E461
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 02:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su87LiltliKlwY2LGGaIGLa5xN3iuDsh4gX5vz5dFPXs0/gcqP311hVxezaPLuVRA0LlDn3bpRox9L2QM7iHDRwh3UJ+cqySKvoiMPxlkqjMs2eOiOtL+vtnTwPyoSHmjNjV8CX5tK5JFCVRFptBPoRhjh+dL3VMn3D5jv0wgi6VFlHEWehdKlBGsMF5i5ZhsvwQaZYhk9hsUAkB2tuudLOG0mKWCfiGSrKRVPJIoDAl/5PduhpeLhXBBCiWBn//WsDTR9nTmrLXMFxTmUN5BOOgsYPTNvGW7Tk6Oxn749jU7ez82TbVTfnJifwhcRRykEeNBTAaEohKoY/vlCAy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31/wdo9kq8BheKxLpd043a/axuD5o0i5TwS8Y3cP5NE=;
 b=hi+Ng0JD7m2QjFu730zPGuVOgtg2B63bd9qhuKuRQNlOIgoBoAEOUQksqskr8L+aKt6Ei0XZUxXgvqQuEPUrOR86U0G6ZL5KiwPDQDG3GOy3SEMTiN+M4MSxz1FDAVGY6B2awjhTn+xrOYJmlF/8SIfTPYYOog8s4ALTuYqsb7+Zg90RmERULnCOYOuvFn6C7yg8OHKtuECn1RgO4CUtoLkfo54N0fNT6mpLXfNU+Tt8lmzYRA1WY+AKSE3+2h8qSXv45xTEtkF7vEffC2MkCA33EOvmALiVWTS/yiwcf4jClQvxkqIXdsNdTCWTg0znFxD/7lc2JTUYMy10VdFkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN8PR12MB3348.namprd12.prod.outlook.com (20.178.211.221) by
 BN8PR12MB3521.namprd12.prod.outlook.com (20.179.65.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Wed, 20 Nov 2019 02:00:12 +0000
Received: from BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::a158:1dcd:18f4:8b81]) by BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::a158:1dcd:18f4:8b81%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 02:00:12 +0000
Subject: Re: [PATCH 06/12] tests/amdgpu: add device handle as input param for
 exec_cs_helper and write_linear_helper (v4)
To: Aaron Liu <aaron.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <1573788895-3936-6-git-send-email-aaron.liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <68a8a4a0-a59d-e721-ac4e-6e64b5838007@amd.com>
Date: Tue, 19 Nov 2019 21:00:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1573788895-3936-6-git-send-email-aaron.liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45)
 To BN8PR12MB3348.namprd12.prod.outlook.com
 (2603:10b6:408:47::29)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f4b44b5-bf9f-4bbe-465b-08d76d5d611b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3521493F4B3B84E0B9527E3E994F0@BN8PR12MB3521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(14454004)(4326008)(52116002)(66946007)(2486003)(76176011)(66556008)(66476007)(23676004)(99286004)(25786009)(65956001)(66066001)(4001150100001)(8936002)(8676002)(65806001)(5660300002)(81156014)(81166006)(86362001)(478600001)(316002)(58126008)(6436002)(6486002)(31696002)(305945005)(47776003)(7736002)(50466002)(476003)(2616005)(44832011)(11346002)(446003)(6116002)(230700001)(186003)(26005)(486006)(36756003)(53546011)(6506007)(386003)(14444005)(3846002)(6512007)(2906002)(6246003)(229853002)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3521;
 H:BN8PR12MB3348.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUJbIQA2s/BuqXcErMdzyQ9lywdyO5776NA9VNChAaZt7PAGgWtKwqd1repZADgZQVI30QavO2SrtBGDmcs1/ptUhcJCF64UTHkClGEt0wTvJ0Kzts0OQOvbUTsdtWtPyK2Dbm3LtkwGXfTYJ99Fe9lS9gNTIO6kmR65wxdPpXPIZGcj3nOjqA7qhPsxWTzr8K1/aTEfUTO6wKtHLNT+NnKcCnvwhMoGylPLyyIK066jg8DpFEzXm8vckF1NwJJXUAYobxPfWBxFIrI2gJ1jgOr0W2JMvzSkJyU1IFIxlGeorxTp67DiFekFvalu+/JvjCaDacVsEFjxti6lV8TxjEDaopWzZTjilfWPPSb18Avm/b84ZoksV+XG78P4A9A+jVoAdS8PF/7k794kJjY1nO08pLQnNsfzrW3Et7PpizlI+Www1KBjXyg3Y4kVnvX/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4b44b5-bf9f-4bbe-465b-08d76d5d611b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 02:00:12.6886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r72TX5odxThw/nDnKlHGi2vbwe4FRxpAaeaMRKAIIC9jOcPRDGPIk8fn7vt3ph02
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3521
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31/wdo9kq8BheKxLpd043a/axuD5o0i5TwS8Y3cP5NE=;
 b=g1HLWGyYYtnYG5FZPrYOtc/6jPg3rGfKRi3iD+GAMyUkRFg32pXg3Uyuvh3DAklXZnKliszxN6WRWLUasQjI85iHnHBGerEmfquZQJuSq/IX1WIiNkVBUFlrlsJL7xKjUotXeQjl1fMvztqLN1/DUy8sZTGppeT8tTE8v55SvoU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
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
Cc: Alexander.Deucher@amd.com, Marek.Olsak@amd.com, Ray.Huang@amd.com,
 Leo.Liu@amd.com, Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120020011.gfY_2WOSyvBMGICabeI2OhhWPTw4JSF11JwtJPVgjao@z>

T24gMjAxOS0xMS0xNCAxMDozNCBwLm0uLCBBYXJvbiBMaXUgd3JvdGU6Cj4gRnJvbTogSHVhbmcg
UnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiAKPiBUaGlzIHBhdGNoIGlzIHRvIGFkZCBhZGQgZGV2
aWNlIGhhbmRsZSBhcyBpbnB1dCBwYXJhbSBmb3IgZXhlY19jc19oZWxwZXIKPiBhbmQgd3JpdGVf
bGluZWFyX2hlbHBlci4KPiAKPiBCZWNhdXNlIHRoZXkgYXJlIG5lZWRlZCBpbiBzZWN1cml0eSB0
ZXN0cy4KPiAKPiB2MjogZml4IHR5cG8gdGhhdCBiYXNpYyB0ZXN0cyBzaG91bGQgYmUgdW4tc2Vj
dXJlLgo+IHYzOiByZWZpbmUgdGhlIGZ1bmN0aW9uIGltcGxlbWVudGF0aW9uLgo+IHY0OiByZW1v
dmUgYW1kZ3B1X2NzX2N0eF9jcmVhdGUzIGNhbGxpbmcuCj4gCj4gU2lnbmVkLW9mZi1ieTogSHVh
bmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBBYXJvbiBMaXUgPGFh
cm9uLmxpdUBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+Cj4gLS0tCj4gIHRlc3RzL2FtZGdwdS9hbWRncHVfdGVzdC5oIHwgIDQg
KysrLQo+ICB0ZXN0cy9hbWRncHUvYmFzaWNfdGVzdHMuYyB8IDUyICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNl
cnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdHMvYW1kZ3B1
L2FtZGdwdV90ZXN0LmggYi90ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaAo+IGluZGV4IDY3YmU0
MzcuLjE2YzJkYTAgMTAwNjQ0Cj4gLS0tIGEvdGVzdHMvYW1kZ3B1L2FtZGdwdV90ZXN0LmgKPiAr
KysgYi90ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaAo+IEBAIC0yNjMsNyArMjYzLDkgQEAgQ1Vf
Qk9PTCBzdWl0ZV9zZWN1cml0eV90ZXN0c19lbmFibGUodm9pZCk7Cj4gIGV4dGVybiBDVV9UZXN0
SW5mbyBzZWN1cml0eV90ZXN0c1tdOwo+ICAKPiAgZXh0ZXJuIHZvaWQKPiAtYW1kZ3B1X2NvbW1h
bmRfc3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVyX3dpdGhfc2VjdXJlKHVuc2lnbmVkIGlw
X3R5cGUsCj4gK2FtZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcl93
aXRoX3NlY3VyZShhbWRncHVfZGV2aWNlX2hhbmRsZQo+ICsJCQkJCQkJICBkZXZpY2UsCj4gKwkJ
CQkJCQkgIHVuc2lnbmVkIGlwX3R5cGUsCj4gIAkJCQkJCQkgIGJvb2wgc2VjdXJlKTsKPiAgCgpX
YXNuJ3QgdGhpcyBhbHJlYWR5IGRvbmUgaW4gcGF0Y2ggNT8KSWYgeWVzLCB0aGVuIGl0IHNob3Vs
ZG4ndCBiZSBkb25lIGhlcmUgYW5kIG9ubHkgYSBzaW5nbGUgaGVhZGVyIGZpbGUKc2hvdWxkIGNv
bnRhaW4gdGhlIHRydXRoLgpJZiBubywgdGhlbiB3aHkgYXJlIHR3byBoZWFkZXIgZmlsZXMgZGVj
bGFyaW5nIHRoaXMgZXh0ZXJuPwpTaG91bGQgYmUgb25seSBvbmUuCgpSZWdhcmRzLApMdWJlbgoK
PiAgLyoqCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jIGIvdGVzdHMv
YW1kZ3B1L2Jhc2ljX3Rlc3RzLmMKPiBpbmRleCAzMWM5YTU0Li41MTU0ODEyIDEwMDY0NAo+IC0t
LSBhL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCj4gKysrIGIvdGVzdHMvYW1kZ3B1L2Jhc2lj
X3Rlc3RzLmMKPiBAQCAtMTI4MywxMiArMTI4MywxNCBAQCBzdGF0aWMgdm9pZCBhbWRncHVfY29t
bWFuZF9zdWJtaXNzaW9uX2NvbXB1dGUodm9pZCkKPiAgICogcG00X3NyYywgcmVzb3VyY2VzLCBp
Yl9pbmZvLCBhbmQgaWJzX3JlcXVlc3QKPiAgICogc3VibWl0IGNvbW1hbmQgc3RyZWFtIGRlc2Ny
aWJlZCBpbiBpYnNfcmVxdWVzdCBhbmQgd2FpdCBmb3IgdGhpcyBJQiBhY2NvbXBsaXNoZWQKPiAg
ICovCj4gLXN0YXRpYyB2b2lkIGFtZGdwdV90ZXN0X2V4ZWNfY3NfaGVscGVyKGFtZGdwdV9jb250
ZXh0X2hhbmRsZSBjb250ZXh0X2hhbmRsZSwKPiAtCQkJCSAgICAgICB1bnNpZ25lZCBpcF90eXBl
LAo+IC0JCQkJICAgICAgIGludCBpbnN0YW5jZSwgaW50IHBtNF9kdywgdWludDMyX3QgKnBtNF9z
cmMsCj4gLQkJCQkgICAgICAgaW50IHJlc19jbnQsIGFtZGdwdV9ib19oYW5kbGUgKnJlc291cmNl
cywKPiAtCQkJCSAgICAgICBzdHJ1Y3QgYW1kZ3B1X2NzX2liX2luZm8gKmliX2luZm8sCj4gLQkJ
CQkgICAgICAgc3RydWN0IGFtZGdwdV9jc19yZXF1ZXN0ICppYnNfcmVxdWVzdCkKPiArc3RhdGlj
IHZvaWQKPiArYW1kZ3B1X3Rlc3RfZXhlY19jc19oZWxwZXJfcmF3KGFtZGdwdV9kZXZpY2VfaGFu
ZGxlIGRldmljZV9oYW5kbGUsCj4gKwkJCSAgICAgICBhbWRncHVfY29udGV4dF9oYW5kbGUgY29u
dGV4dF9oYW5kbGUsCj4gKwkJCSAgICAgICB1bnNpZ25lZCBpcF90eXBlLCBpbnQgaW5zdGFuY2Us
IGludCBwbTRfZHcsCj4gKwkJCSAgICAgICB1aW50MzJfdCAqcG00X3NyYywgaW50IHJlc19jbnQs
Cj4gKwkJCSAgICAgICBhbWRncHVfYm9faGFuZGxlICpyZXNvdXJjZXMsCj4gKwkJCSAgICAgICBz
dHJ1Y3QgYW1kZ3B1X2NzX2liX2luZm8gKmliX2luZm8sCj4gKwkJCSAgICAgICBzdHJ1Y3QgYW1k
Z3B1X2NzX3JlcXVlc3QgKmlic19yZXF1ZXN0KQo+ICB7Cj4gIAlpbnQgcjsKPiAgCXVpbnQzMl90
IGV4cGlyZWQ7Cj4gQEAgLTEzNjEsOCArMTM2MywyNCBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdGVz
dF9leGVjX2NzX2hlbHBlcihhbWRncHVfY29udGV4dF9oYW5kbGUgY29udGV4dF9oYW5kbGUsCj4g
IAlDVV9BU1NFUlRfRVFVQUwociwgMCk7Cj4gIH0KPiAgCj4gLXZvaWQgYW1kZ3B1X2NvbW1hbmRf
c3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVyX3dpdGhfc2VjdXJlKHVuc2lnbmVkIGlwX3R5
cGUsCj4gLQkJCQkJCQkgICAgICAgYm9vbCBzZWN1cmUpCj4gK3N0YXRpYyB2b2lkCj4gK2FtZGdw
dV90ZXN0X2V4ZWNfY3NfaGVscGVyKGFtZGdwdV9jb250ZXh0X2hhbmRsZSBjb250ZXh0X2hhbmRs
ZSwKPiArCQkJICAgdW5zaWduZWQgaXBfdHlwZSwgaW50IGluc3RhbmNlLCBpbnQgcG00X2R3LAo+
ICsJCQkgICB1aW50MzJfdCAqcG00X3NyYywgaW50IHJlc19jbnQsCj4gKwkJCSAgIGFtZGdwdV9i
b19oYW5kbGUgKnJlc291cmNlcywKPiArCQkJICAgc3RydWN0IGFtZGdwdV9jc19pYl9pbmZvICpp
Yl9pbmZvLAo+ICsJCQkgICBzdHJ1Y3QgYW1kZ3B1X2NzX3JlcXVlc3QgKmlic19yZXF1ZXN0KQo+
ICt7Cj4gKwlhbWRncHVfdGVzdF9leGVjX2NzX2hlbHBlcl9yYXcoZGV2aWNlX2hhbmRsZSwgY29u
dGV4dF9oYW5kbGUsCj4gKwkJCQkgICAgICAgaXBfdHlwZSwgaW5zdGFuY2UsIHBtNF9kdywgcG00
X3NyYywKPiArCQkJCSAgICAgICByZXNfY250LCByZXNvdXJjZXMsIGliX2luZm8sCj4gKwkJCQkg
ICAgICAgaWJzX3JlcXVlc3QpOwo+ICt9Cj4gKwo+ICt2b2lkCj4gK2FtZGdwdV9jb21tYW5kX3N1
Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcl93aXRoX3NlY3VyZShhbWRncHVfZGV2aWNlX2hh
bmRsZQo+ICsJCQkJCQkJICBkZXZpY2UsIHVuc2lnbmVkCj4gKwkJCQkJCQkgIGlwX3R5cGUsIGJv
b2wgc2VjdXJlKQo+ICB7Cj4gIAljb25zdCBpbnQgc2RtYV93cml0ZV9sZW5ndGggPSAxMjg7Cj4g
IAljb25zdCBpbnQgcG00X2R3ID0gMjU2Owo+IEBAIC0xMzg4LDEzICsxNDA2LDEzIEBAIHZvaWQg
YW1kZ3B1X2NvbW1hbmRfc3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVyX3dpdGhfc2VjdXJl
KHVuc2lnbmVkIGlwX3R5cGUsCj4gIAlpYnNfcmVxdWVzdCA9IGNhbGxvYygxLCBzaXplb2YoKmli
c19yZXF1ZXN0KSk7Cj4gIAlDVV9BU1NFUlRfTk9UX0VRVUFMKGlic19yZXF1ZXN0LCBOVUxMKTsK
PiAgCj4gLQlyID0gYW1kZ3B1X3F1ZXJ5X2h3X2lwX2luZm8oZGV2aWNlX2hhbmRsZSwgaXBfdHlw
ZSwgMCwgJmh3X2lwX2luZm8pOwo+ICsJciA9IGFtZGdwdV9xdWVyeV9od19pcF9pbmZvKGRldmlj
ZSwgaXBfdHlwZSwgMCwgJmh3X2lwX2luZm8pOwo+ICAJQ1VfQVNTRVJUX0VRVUFMKHIsIDApOwo+
ICAKPiAgCWZvciAoaSA9IDA7IHNlY3VyZSAmJiAoaSA8IDIpOyBpKyspCj4gIAkJZ3R0X2ZsYWdz
W2ldIHw9IEFNREdQVV9HRU1fQ1JFQVRFX0VOQ1JZUFRFRDsKPiAgCj4gLQlyID0gYW1kZ3B1X2Nz
X2N0eF9jcmVhdGUoZGV2aWNlX2hhbmRsZSwgJmNvbnRleHRfaGFuZGxlKTsKPiArCXIgPSBhbWRn
cHVfY3NfY3R4X2NyZWF0ZShkZXZpY2UsICZjb250ZXh0X2hhbmRsZSk7Cj4gIAo+ICAJQ1VfQVNT
RVJUX0VRVUFMKHIsIDApOwo+ICAKPiBAQCAtMTQwNiw3ICsxNDI0LDcgQEAgdm9pZCBhbWRncHVf
Y29tbWFuZF9zdWJtaXNzaW9uX3dyaXRlX2xpbmVhcl9oZWxwZXJfd2l0aF9zZWN1cmUodW5zaWdu
ZWQgaXBfdHlwZSwKPiAgCQlsb29wID0gMDsKPiAgCQl3aGlsZShsb29wIDwgMikgewo+ICAJCQkv
KiBhbGxvY2F0ZSBVQyBibyBmb3Igc0RNQSB1c2UgKi8KPiAtCQkJciA9IGFtZGdwdV9ib19hbGxv
Y19hbmRfbWFwKGRldmljZV9oYW5kbGUsCj4gKwkJCXIgPSBhbWRncHVfYm9fYWxsb2NfYW5kX21h
cChkZXZpY2UsCj4gIAkJCQkJCSAgICBzZG1hX3dyaXRlX2xlbmd0aCAqIHNpemVvZih1aW50MzJf
dCksCj4gIAkJCQkJCSAgICA0MDk2LCBBTURHUFVfR0VNX0RPTUFJTl9HVFQsCj4gIAkJCQkJCSAg
ICBndHRfZmxhZ3NbbG9vcF0sICZibywgKHZvaWQqKikmYm9fY3B1LAo+IEBAIC0xNDQ1LDExICsx
NDYzLDEwIEBAIHZvaWQgYW1kZ3B1X2NvbW1hbmRfc3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVs
cGVyX3dpdGhfc2VjdXJlKHVuc2lnbmVkIGlwX3R5cGUsCj4gIAkJCQkJcG00W2krK10gPSAweGRl
YWRiZWFmOwo+ICAJCQl9Cj4gIAo+IC0JCQlhbWRncHVfdGVzdF9leGVjX2NzX2hlbHBlcihjb250
ZXh0X2hhbmRsZSwKPiAtCQkJCQkJICAgaXBfdHlwZSwgcmluZ19pZCwKPiAtCQkJCQkJICAgaSwg
cG00LAo+IC0JCQkJCQkgICAxLCByZXNvdXJjZXMsCj4gLQkJCQkJCSAgIGliX2luZm8sIGlic19y
ZXF1ZXN0KTsKPiArCQkJYW1kZ3B1X3Rlc3RfZXhlY19jc19oZWxwZXJfcmF3KGRldmljZSwgY29u
dGV4dF9oYW5kbGUsCj4gKwkJCQkJCSAgICAgICBpcF90eXBlLCByaW5nX2lkLCBpLCBwbTQsCj4g
KwkJCQkJCSAgICAgICAxLCByZXNvdXJjZXMsIGliX2luZm8sCj4gKwkJCQkJCSAgICAgICBpYnNf
cmVxdWVzdCk7Cj4gIAo+ICAJCQkvKiB2ZXJpZnkgaWYgU0RNQSB0ZXN0IHJlc3VsdCBtZWV0cyB3
aXRoIGV4cGVjdGVkICovCj4gIAkJCWkgPSAwOwo+IEBAIC0xNDc2LDcgKzE0OTMsOCBAQCB2b2lk
IGFtZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcl93aXRoX3NlY3Vy
ZSh1bnNpZ25lZCBpcF90eXBlLAo+ICAKPiAgc3RhdGljIHZvaWQgYW1kZ3B1X2NvbW1hbmRfc3Vi
bWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVyKHVuc2lnbmVkIGlwX3R5cGUpCj4gIHsKPiAtCWFt
ZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcl93aXRoX3NlY3VyZShp
cF90eXBlLAo+ICsJYW1kZ3B1X2NvbW1hbmRfc3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVy
X3dpdGhfc2VjdXJlKGRldmljZV9oYW5kbGUsCj4gKwkJCQkJCQkJICBpcF90eXBlLAo+ICAJCQkJ
CQkJCSAgZmFsc2UpOwo+ICB9Cj4gIAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
