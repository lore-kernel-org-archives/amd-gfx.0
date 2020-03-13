Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C74FC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 17:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DAA206B7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 17:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bnkg7HBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DAA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02A489A92;
	Fri, 13 Mar 2020 17:36:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8613C89A92
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 17:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYJpvRZ9F0W/MyBXVdaPaH/1NKoZWUAfa8X8DXAeTrNsIZKBWh796wHmGl4fUkmattgUjCvRnD+KWan8QUhn5C5dUIoPzZsB8e2C8KKYxZlBHo09emxoshL9MSn8lLSHkfytH8qjXjY4nqq9DQnGs/A1N1RCoY8v6A98+ZBQk6+Eq+HKQUtW9VUEs6lxj9c+8ZRXPMsaLeUHjm1IcRbWzadq4nWhEXyb+CKqL/ew9LUcNh1LJc5R8NF4wcVw5DrLA1Hs0HpueCgBoDhYzRLuE1BQJ1eHybHAZobRL/POPttPwwAT3HsT7sw/VDI/NpZmEXo5cluNTJBJqB+p/wAJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw42Gjwz44AMg4mMEi+dkXEHjzt6gEMS30OZLTx7I2w=;
 b=CG7BPQz3fgdt69Odbkiof1C7X48Jr7q8aL0+/Wk3zUT3QbUvnIHGrefHYayIJGdaSgpj8B6jCd+bCuMe5bOV028ZcF599Ede9E4fOtR5ctm9dPbU5AfRvQx+JNs955FRWOp5cqajhFb25hS5z9OcoWluRVSp1++dNIBPi61K3vQS19b++ckXBLF85NKKqRBN0mBIHINaxHkaCZf779iJzdqenbFadZK3IgJ6r3pRqpQtFNS3jtQqvQjQa+d1FbutdHP77BKbpEIdYcppHsNQ/GGFxd+iWSEgECxJJg5X1SVjjNteCHFDAT3ZN8vQxdbeVST+yem444zeTh/DVdFq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw42Gjwz44AMg4mMEi+dkXEHjzt6gEMS30OZLTx7I2w=;
 b=bnkg7HBWwwssFhLWIbWryvUdFTuf7FQUI2DMC/6ej7kuFpFjN4A3oY18dq5euW6we00vV2k+g3wLOCYUv3dvITaKEZpXbufLRNto7GfHEwbFnZfOdY1WOu5LpRPqaODML//Mt7A+Z/qh8GMHATGhiZf1wiGyMC1YMmjXh+vj2gQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5SPR00MB2480.namprd12.prod.outlook.com (2603:10b6:3:48::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Fri, 13 Mar
 2020 17:36:25 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 17:36:25 +0000
Subject: Re: [PATCH v4 2/2] drm/amdgpu: unref pt bo after job submit
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200313160933.10394-1-xinhui.pan@amd.com>
 <20200313160933.10394-3-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2b38aa48-40c1-2830-0005-2ddca7672535@amd.com>
Date: Fri, 13 Mar 2020 13:36:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200313160933.10394-3-xinhui.pan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::15) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.21] (142.116.63.128) by
 YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Fri, 13 Mar 2020 17:36:25 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0423966-865f-4afe-1824-08d7c7750dc3
X-MS-TrafficTypeDiagnostic: DM5SPR00MB2480:|DM5SPR00MB2480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5SPR00MB248053DD9F11E3B13EEA73AA92FA0@DM5SPR00MB2480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:136;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(53546011)(26005)(81156014)(2616005)(8676002)(81166006)(31686004)(52116002)(478600001)(8936002)(44832011)(16576012)(6486002)(36756003)(316002)(66574012)(2906002)(54906003)(31696002)(66476007)(5660300002)(86362001)(66946007)(66556008)(186003)(4326008)(956004)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5SPR00MB2480;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skYTbXa+C8zFfePDenkaPJQczYmWvjKIh/RslY3pm4yMbBPFUgVHnP9JXKKW1zKERqu67X55UHN/+/APRBn3FAnVCRHCBxVhp6zHzVztfBcWu6enoUCnrPqpG1z9UgQDFAl/wKEmUtOQ7TmYBTFGZgiz7Vb2uap7Jo5OvLKhE4AZ08Wa4HQ5vTFWxnYJ8tWtrW9sl4OmYR0BhYqCwsHOkOV0ZqQnMk8HdfOjuZMH3/Q4TzFYgTbaJp3Vf/O4q06frZi5/jSUMbO2IEU4LKrr29IzL9kbGyXZgYoi9uR9xmZrs/x2Q/bqo19JHqYpTpDsNlGolHEHTIM5KVUI2xYP2/3PZKVJMVCo4xP0USmc5vPPvHTi6L/L9B1BiB9k6DjCj+ybT4b7N4fscfMISmqprMSmjm5U05jsPOcqRnKZIXCwS0MqdEDkcQXhuCUs6B5F
X-MS-Exchange-AntiSpam-MessageData: 9EshhhR+GoonmX5wHxUl15uhpfi0nGWjyzNZANAd06cdpQw9RDx2bHxqec6QvoJaXXstlZyXMrHubR7iXK9V8yIgMP/CWrGFc4NCB0U295d+3EjP+5qOcetCcbFmJuLWFULxZjqHG0lq/vs86NC0ew==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0423966-865f-4afe-1824-08d7c7750dc3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 17:36:25.4744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqtovbfKr1vusa677fTeKJNm72HQA9W0hlLdv15EiGvsCkpLpOyRcMrSOR2g+KZzJkJZgjAHda4O595ZHIoTFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR00MB2480
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBzZWVtcyB3ZWlyZC4gVGhpcyBtZWFucyB0aGF0IHdlIHVwZGF0ZSBhIHBhZ2UgdGFibGUs
IGFuZCB0aGVuIGZyZWUgCml0IGluIHRoZSBzYW1lIGFtZGdwdV92bV91cGRhdGVfcHRlcyBjYWxs
PyBUaGF0IG1lYW5zIHRoZSB1cGRhdGUgaXMgCnJlZHVuZGFudC4gQ2FuIHdlIGVsaW1pbmF0ZSB0
aGUgcmVkdW5kYW50IFBURSB1cGRhdGUgaWYgdGhlIHBhZ2UgdGFibGUgCmlzIGFib3V0IHRvIGJl
IGZyZWVkIGFueXdheT8KClJlZ2FyZHMsCiDCoCBGZWxpeAoKT24gMjAyMC0wMy0xMyAxMjowOSwg
eGluaHVpIHBhbiB3cm90ZToKPiBGcmVlIHBhZ2UgdGFibGUgYm8gYmVmb3JlIGpvYiBzdWJtaXQg
aXMgaW5zYW5lLgo+IFdlIG1pZ2h0IHRvdWNoIGludmFsaWQgbWVtb3J5IHdoaWxlIGpvYiBpcyBy
dW5uaWcuCj4KPiB3ZSBub3cgaGF2ZSBpbmRpdmlkdWFsaXplZCBibyByZXN2IGR1cmluZyBibyBy
ZWxlYXNpbmcuCj4gU28gYW55IGZlbmNlcyBhZGRlZCB0byByb290IFBUIGJvIGlzIGFjdHVhbGx5
IHVudGVzdGVkIHdoZW4KPiBhIG5vcm1hbCBQVCBibyBpcyByZWxlYXNpbmcuCj4KPiBXZSBtaWdo
dCBoaXQgZ21jIHBhZ2UgZmF1bHQgb3IgbWVtb3J5IGp1c3QgZ290IG92ZXJ3cml0ZWQuCj4KPiBD
YzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6IEZlbGl4IEt1ZWhsaW5n
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhp
bmh1aS5wYW5AYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCB8ICAzICsrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAy
NCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCA3MzM5ODgzMTE5NmYuLjM0NmUyZjc1MzQ3NCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTkzNyw2ICs5MzcsMjEg
QEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRzKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAo+ICAgCXJldHVybiByOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lkIGFtZGdwdV92bV9m
cmVlX3pvbWJpZV9ibyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiArCQlzdHJ1Y3QgYW1k
Z3B1X3ZtICp2bSkKPiArewo+ICsJc3RydWN0IGFtZGdwdV92bV9wdCAqZW50cnk7Cj4gKwo+ICsJ
d2hpbGUgKCFsaXN0X2VtcHR5KCZ2bS0+em9tYmllcykpIHsKPiArCQllbnRyeSA9IGxpc3RfZmly
c3RfZW50cnkoJnZtLT56b21iaWVzLCBzdHJ1Y3QgYW1kZ3B1X3ZtX3B0LAo+ICsJCQkJYmFzZS52
bV9zdGF0dXMpOwo+ICsJCWxpc3RfZGVsKCZlbnRyeS0+YmFzZS52bV9zdGF0dXMpOwo+ICsKPiAr
CQlhbWRncHVfYm9fdW5yZWYoJmVudHJ5LT5iYXNlLmJvLT5zaGFkb3cpOwo+ICsJCWFtZGdwdV9i
b191bnJlZigmZW50cnktPmJhc2UuYm8pOwo+ICsJfQo+ICt9Cj4gKwo+ICAgLyoqCj4gICAgKiBh
bWRncHVfdm1fZnJlZV90YWJsZSAtIGZyZSBvbmUgUEQvUFQKPiAgICAqCj4gQEAgLTk0NSwxMCAr
OTYwLDkgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRzKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAo+ICAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2ZyZWVfdGFibGUoc3RydWN0IGFt
ZGdwdV92bV9wdCAqZW50cnkpCj4gICB7Cj4gICAJaWYgKGVudHJ5LT5iYXNlLmJvKSB7Cj4gKwkJ
bGlzdF9tb3ZlKCZlbnRyeS0+YmFzZS52bV9zdGF0dXMsCj4gKwkJCQkmZW50cnktPmJhc2UuYm8t
PnZtX2JvLT52bS0+em9tYmllcyk7Cj4gICAJCWVudHJ5LT5iYXNlLmJvLT52bV9ibyA9IE5VTEw7
Cj4gLQkJbGlzdF9kZWwoJmVudHJ5LT5iYXNlLnZtX3N0YXR1cyk7Cj4gLQkJYW1kZ3B1X2JvX3Vu
cmVmKCZlbnRyeS0+YmFzZS5iby0+c2hhZG93KTsKPiAtCQlhbWRncHVfYm9fdW5yZWYoJmVudHJ5
LT5iYXNlLmJvKTsKPiAgIAl9Cj4gICAJa3ZmcmVlKGVudHJ5LT5lbnRyaWVzKTsKPiAgIAllbnRy
eS0+ZW50cmllcyA9IE5VTEw7Cj4gQEAgLTE2MjQsNiArMTYzOCw3IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAg
CXIgPSB2bS0+dXBkYXRlX2Z1bmNzLT5jb21taXQoJnBhcmFtcywgZmVuY2UpOwo+ICAgCj4gICBl
cnJvcl91bmxvY2s6Cj4gKwlhbWRncHVfdm1fZnJlZV96b21iaWVfYm8oYWRldiwgdm0pOwo+ICAg
CWFtZGdwdV92bV9ldmljdGlvbl91bmxvY2sodm0pOwo+ICAgCXJldHVybiByOwo+ICAgfQo+IEBA
IC0yODA3LDYgKzI4MjIsNyBAQCBpbnQgYW1kZ3B1X3ZtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAo+ICAgCUlOSVRfTElTVF9IRUFEKCZ2bS0+
aW52YWxpZGF0ZWQpOwo+ICAgCXNwaW5fbG9ja19pbml0KCZ2bS0+aW52YWxpZGF0ZWRfbG9jayk7
Cj4gICAJSU5JVF9MSVNUX0hFQUQoJnZtLT5mcmVlZCk7Cj4gKwlJTklUX0xJU1RfSEVBRCgmdm0t
PnpvbWJpZXMpOwo+ICAgCj4gICAKPiAgIAkvKiBjcmVhdGUgc2NoZWR1bGVyIGVudGl0aWVzIGZv
ciBwYWdlIHRhYmxlIHVwZGF0ZXMgKi8KPiBAQCAtMzExOSw2ICszMTM1LDggQEAgdm9pZCBhbWRn
cHVfdm1fZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAq
dm0pCj4gICAJfQo+ICAgCj4gICAJYW1kZ3B1X3ZtX2ZyZWVfcHRzKGFkZXYsIHZtLCBOVUxMKTsK
PiArCWFtZGdwdV92bV9mcmVlX3pvbWJpZV9ibyhhZGV2LCB2bSk7Cj4gKwo+ICAgCWFtZGdwdV9i
b191bnJlc2VydmUocm9vdCk7Cj4gICAJYW1kZ3B1X2JvX3VucmVmKCZyb290KTsKPiAgIAlXQVJO
X09OKHZtLT5yb290LmJhc2UuYm8pOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5oCj4gaW5kZXggYjU3MDVmY2ZjOTM1Li45YmFmNDRmYTE2ZjAgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAo+IEBAIC0yNjksNiArMjY5LDkgQEAgc3RydWN0IGFt
ZGdwdV92bSB7Cj4gICAJLyogQk8gbWFwcGluZ3MgZnJlZWQsIGJ1dCBub3QgeWV0IHVwZGF0ZWQg
aW4gdGhlIFBUICovCj4gICAJc3RydWN0IGxpc3RfaGVhZAlmcmVlZDsKPiAgIAo+ICsJLyogQk8g
d2lsbCBiZSBmcmVlZCBzb29uICovCj4gKwlzdHJ1Y3QgbGlzdF9oZWFkCXpvbWJpZXM7Cj4gKwo+
ICAgCS8qIGNvbnRhaW5zIHRoZSBwYWdlIGRpcmVjdG9yeSAqLwo+ICAgCXN0cnVjdCBhbWRncHVf
dm1fcHQgICAgIHJvb3Q7Cj4gICAJc3RydWN0IGRtYV9mZW5jZQkqbGFzdF91cGRhdGU7Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
