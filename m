Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45546C35242
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 21:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE4D217F4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 21:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T4bQxXln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE4D217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A32B86E861;
	Fri, 14 Feb 2020 21:12:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770089.outbound.protection.outlook.com [40.107.77.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B225A6E861
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 21:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0buhr9f9I50Hqbwp7szEZxNYZWnD0Mr5Dmf/tfwfBYzMhVJzIsdPGmX17hAcpTmbguS+uvfhYwhublp41fYeOXU4XkgFHxQ3879CaVP4EeHtC3T6uqanLl95pBNUKjQl899AnILjO5OLEbheaJZ0PvMO3Bms8Mer3RRQCMcADYwds399M3DZ4qJQefcBx3sR2wCAWVCijBNVIPBDCqDsjdPvuN35E7bmcZubgjcOQHhhLSPxpE1xoc82tVFbstt5u2dCW6XzTQcx0lZGVQ3q95SRgDZD/peDKCkN+v/6ebpLKJfxvVazY12yNp8LSaytlnFu0AY0AqmhJ5oJZtEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBWf230GWx/vJqZrK4jyqmgxRlQQkYjp86qg4voYwJc=;
 b=R1kYekYzeMKaXPL5fRBh7R6OVQ68KqfY/g7mPJ8DHpUlKi39+YxXx1avUobutHew/kp3k8FaiGwEBTkJmWe9ibOOjZcjNBw50FyXWeXQRBgDXlWIaIS152G8PqzwkpqudBEmOgsW8KLLra/iKap0LUiVG351r2djP5mO8uEHeIXQ6vAaOq5ViPNvTw3nI4CqsFrsKsKPrJnIXedGKU30w1QQV2qZw5y6CEVQXGnI3wqAI7zbM732qiyoKGn0tq335CrOwnWOzkGCJWgoRdIdlHyc+lSKZ42TJ9300AFdXKWgU6o+3atOGQreWM9h2E/ah28McWv/CcTmlKTDM4rT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBWf230GWx/vJqZrK4jyqmgxRlQQkYjp86qg4voYwJc=;
 b=T4bQxXlnY6YQT/oE3IqutVrxWw8kSKOk26tjE1rtEdjgWzh6oRJeBFal/VbvhTUzjdsS7Qpy7mFqntUDfCexeATLHQzbxvOvbEVjA4Lnp5JgbG3O3r+a/xuFRN2EJloiUHZJC7S9Bemw4+LU2qn47e1g1fZFR+lgicxznIghPW8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0220.namprd12.prod.outlook.com (10.174.247.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 21:12:37 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 21:12:37 +0000
Subject: Re: [PATCH] drm/amdgpu: stop allocating PDs/PTs with the eviction
 lock held
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alex.sierra@amd.com, amd-gfx@lists.freedesktop.org
References: <20200212151426.14197-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <7f0c6e3e-be75-3fa8-a5e7-d8ae6bf0dba5@amd.com>
Date: Fri, 14 Feb 2020 16:12:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200212151426.14197-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::17) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Fri, 14 Feb 2020 21:12:36 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4f42b8f-6508-4649-9798-08d7b1929dc5
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0220:|DM5PR1201MB0220:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0220B89E4054408422697C9792150@DM5PR1201MB0220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(53546011)(26005)(5660300002)(478600001)(16526019)(6486002)(66574012)(36756003)(31686004)(186003)(8936002)(956004)(2906002)(36916002)(86362001)(52116002)(31696002)(66946007)(44832011)(316002)(2616005)(81166006)(8676002)(66556008)(81156014)(16576012)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0220;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4P+qZLDmWTg4xaRUq79nmRPEe94ZOth4bpgoF0BOMiuegFXv8CUiF11NNtxzmOg3z3rvqDhMkPO++oWkcSdtv9kNyHegVDzTSoMR8FasAz1I8qCxsY8CDGR789yAA1LLu3Gy4L9brUFPDUcP7wcCcEN+keYAFwM9IH2L+Cql4XbJFjBtTwFY6T1SHQX/6eVxSg59auDB0ePIgopEQKg4avIva3PBNiuOtbThltsnpc9yyKtMz8+bRk4woglsziG/tlRHd1SVWIbc01gJDdg7fqxJUL+jBhGpbjdhXswe1EmwT1tbnLO3gHxcfF3/8VRD2mfU00/BzLRZ4cCN/Xnj6BJYTr3ejOhoyY7Wr4eI5Spko6mGiN5i7Qdy7AJUnszRi7QvkfobShE6teWdS2VwXtobSGpoaDoDn/f3rkCNkPjcu4JbQCUL5xgbVx9M0y/i
X-MS-Exchange-AntiSpam-MessageData: /5/N9oZoMfNv06AqhMwPyqv1RkMWQFzKhZX8PYLOEGcg2v5o0M3uKkjaFRxiRb/YpoBkJnywyaAyAQycemGAb/YBBnMrnWWvZbqHp+f1SsVk6hUeZGzL3/TJ38ZDomYfwerpxCh4G+evyuP+twgRpg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f42b8f-6508-4649-9798-08d7b1929dc5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 21:12:36.8817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MBD1cIiD1Sb09xAsRoiuo69XqmiNjktjl1HzX++9zrnUTms43ecytUucNYxQgb/2v6GhZn1MFQHvZgi8Yj4LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
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

Tm93IHlvdSBhbGxvdyBldmljdGlvbiBvZiBwYWdlIHRhYmxlcyB3aGlsZSB5b3UgYWxsb2NhdGUg
cGFnZSB0YWJsZXMuIApJc24ndCB0aGUgd2hvbGUgcG9pbnQgb2YgdGhlIGV2aWN0aW9uIGxvY2sg
dG8gcHJldmVudCBwYWdlIHRhYmxlIApldmljdGlvbnMgd2hpbGUgbWFuaXB1bGF0aW5nIHBhZ2Ug
dGFibGVzPwoKT3IgZG9lcyB0aGlzIG9ubHkgYXBwbHkgdG8gUFRFIGludmFsaWRhdGlvbnMgd2hp
Y2ggbmV2ZXIgYWxsb2NhdGVkIAptZW1vcnk/IElzIHRoYXQgdGhlIG9ubHkgY2FzZSB0aGF0IGRv
ZXNuJ3QgcmVzZXJ2ZSBwYWdlIHRhYmxlcz8KClJlZ2FyZHMsCiDCoCBGZWxpeAoKT24gMjAyMC0w
Mi0xMiAxMDoxNCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IFdlIG5lZWQgdG8gbWFr
ZSBzdXJlIHRvIG5vdCBhbGxvY2F0ZSBQRHMvUFRzIHdoaWxlIGhvbGRpbmcKPiB0aGUgZXZpY3Rp
b24gbG9jayBvciBvdGhlcndpc2Ugd2Ugd2lsbCBydW4gaW50byBsb2NrIGludmVyc2lvbgo+IGlu
IHRoZSBNTSBhcyBzb29uIGFzIHdlIGVuYWJsZSB0aGUgTU1VIG5vdGlmaWVyLgo+Cj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IC0t
LQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAzMSArKysrKysr
KysrKysrKysrKysrKystLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+
IGluZGV4IDc3YzQwMDY3NWI3OS4uZTdhYjBjMWUyNzkzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtODk3LDI3ICs4OTcsNDIgQEAgc3RhdGljIGludCBh
bWRncHVfdm1fYWxsb2NfcHRzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCXN0cnVj
dCBhbWRncHVfdm1fcHQgKmVudHJ5ID0gY3Vyc29yLT5lbnRyeTsKPiAgIAlzdHJ1Y3QgYW1kZ3B1
X2JvX3BhcmFtIGJwOwo+ICAgCXN0cnVjdCBhbWRncHVfYm8gKnB0Owo+ICsJYm9vbCBuZWVkX2Vu
dHJpZXM7Cj4gICAJaW50IHI7Cj4gICAKPiAtCWlmIChjdXJzb3ItPmxldmVsIDwgQU1ER1BVX1ZN
X1BUQiAmJiAhZW50cnktPmVudHJpZXMpIHsKPiArCW5lZWRfZW50cmllcyA9IGN1cnNvci0+bGV2
ZWwgPCBBTURHUFVfVk1fUFRCICYmICFlbnRyeS0+ZW50cmllczsKPiArCWlmICghbmVlZF9lbnRy
aWVzICYmIGVudHJ5LT5iYXNlLmJvKQo+ICsJCXJldHVybiAwOwo+ICsKPiArCS8qIFdlIG5lZWQg
dG8gbWFrZSBzdXJlIHRoYXQgd2UgZG9uJ3QgYWxsb2NhdGUgUERzL1BUcyB3aGlsZSBob2xkaW5n
IHRoZQo+ICsJICogZXZpY3Rpb24gbG9jayBvciB3ZSBydW4gaW50byBsb2NrIHJlY3Vyc2lvbiBp
biB0aGUgTU0uCj4gKwkgKi8KPiArCWFtZGdwdV92bV9ldmljdGlvbl91bmxvY2sodm0pOwo+ICsK
PiArCWlmIChuZWVkX2VudHJpZXMpIHsKPiAgIAkJdW5zaWduZWQgbnVtX2VudHJpZXM7Cj4gICAK
PiAgIAkJbnVtX2VudHJpZXMgPSBhbWRncHVfdm1fbnVtX2VudHJpZXMoYWRldiwgY3Vyc29yLT5s
ZXZlbCk7Cj4gICAJCWVudHJ5LT5lbnRyaWVzID0ga3ZtYWxsb2NfYXJyYXkobnVtX2VudHJpZXMs
Cj4gICAJCQkJCQlzaXplb2YoKmVudHJ5LT5lbnRyaWVzKSwKPiAgIAkJCQkJCUdGUF9LRVJORUwg
fCBfX0dGUF9aRVJPKTsKPiAtCQlpZiAoIWVudHJ5LT5lbnRyaWVzKQo+IC0JCQlyZXR1cm4gLUVO
T01FTTsKPiArCQlpZiAoIWVudHJ5LT5lbnRyaWVzKSB7Cj4gKwkJCXIgPSAtRU5PTUVNOwo+ICsJ
CQlnb3RvIGVycm9yX2xvY2s7Cj4gKwkJfQo+ICAgCX0KPiAgIAo+IC0JaWYgKGVudHJ5LT5iYXNl
LmJvKQo+IC0JCXJldHVybiAwOwo+ICsJaWYgKGVudHJ5LT5iYXNlLmJvKSB7Cj4gKwkJciA9IDA7
Cj4gKwkJZ290byBlcnJvcl9sb2NrOwo+ICsJfQo+ICAgCj4gICAJYW1kZ3B1X3ZtX2JvX3BhcmFt
KGFkZXYsIHZtLCBjdXJzb3ItPmxldmVsLCBkaXJlY3QsICZicCk7Cj4gICAKPiAgIAlyID0gYW1k
Z3B1X2JvX2NyZWF0ZShhZGV2LCAmYnAsICZwdCk7Cj4gKwlhbWRncHVfdm1fZXZpY3Rpb25fbG9j
ayh2bSk7Cj4gICAJaWYgKHIpCj4gLQkJcmV0dXJuIHI7Cj4gKwkJZ290byBlcnJvcl9mcmVlX3B0
Owo+ICAgCj4gICAJLyogS2VlcCBhIHJlZmVyZW5jZSB0byB0aGUgcm9vdCBkaXJlY3RvcnkgdG8g
YXZvaWQKPiAgIAkgKiBmcmVlaW5nIHRoZW0gdXAgaW4gdGhlIHdyb25nIG9yZGVyLgo+IEBAIC05
MzYsNiArOTUxLDEwIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2FsbG9jX3B0cyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKPiAgIAlhbWRncHVfYm9fdW5yZWYoJnB0KTsKPiAgIAllbnRyeS0+
YmFzZS5ibyA9IE5VTEw7Cj4gICAJcmV0dXJuIHI7Cj4gKwo+ICtlcnJvcl9sb2NrOgo+ICsJYW1k
Z3B1X3ZtX2V2aWN0aW9uX2xvY2sodm0pOwo+ICsJcmV0dXJuIHI7Cj4gICB9Cj4gICAKPiAgIC8q
KgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
