Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9118CC2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 22:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5091524125
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 22:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qbaYDt/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5091524125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F6F6E4C7;
	Tue, 21 Jan 2020 22:42:00 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690080.outbound.protection.outlook.com [40.107.69.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD1786E4C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 22:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnD3nIDwA1cWq7fEXlu07V5ApVZzx5TWqet7OJkp8ECBo3MB571DqRSDCSlN/l5ySfd+W/8tHmyd1F2tcByCCoPMGdynwDcOwdal+jtKzYO575lD4VhGU19ei5vrY5YITsR3d7uDMnuivpatk1fZPrOz9Y9w2rD6L41cpDJc0caW9DwmMARhfmjj2Hz45hphlOSCtV94tT1JTSTdIbTrU9NfH2PA+hxAlLd2oH9IeGAogeAmZoQ0C1punWvgJwJFyD5VWwo9gRH4K3lPgCIGq7zGvIouv4j/lGDkGAeyVt9DdjUHTa9oLFDUczWTRj3PyfTOexib4kxVJo2PhnXGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh9BUpez+qBxQW3ugD5Y6nG6suZ20vafS8+XSSQJ8DM=;
 b=NP/djT8Y+ZL2Fw42YIazvsnX1dNsUF7KGcNaSGEQ5hpZ7deOwwFtB4Rde0cnoPSiw1mHL9vCbHF2lHNTgGuYzbcvedvrXN5qsGOmexQ83S7Z8hnI6U0teqggBCP4RVOJVfa+hWAc7Iq+zP5XPboDJD7n7al1AXP11h+lJwxOOfvMAsQWC9RyCY4FukN+3WbdR8RlYw+/LNg/f5LHD5LyfYkM9fUpKdnmylt7zBYOoPLHm5uRJ9t9TY4L7zM12IiCdgZik9Y0HScSeHXk7z3k+gnzO8vLE6Ur3OkGcB7MfU2i7G4eYmhSS3wsjX2R77j9OfuiPGPO0dTnNEYIhXZ+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh9BUpez+qBxQW3ugD5Y6nG6suZ20vafS8+XSSQJ8DM=;
 b=qbaYDt/uCGKK/Aj+XqDPjsqYTS93wG/jlkZHcf/tPoDAopD1XF9rK0Tz54iuM07o0IEXpY2j7u5EKsLK+mCXHYexqE7i/hbrAdfqOb0NaOQSJIziPcsOnx3ko0OmpQ0AaoV1muyFQk8T8By4KwH8SLMj1/jK+kDD5MUt9w5vEdc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0201.namprd12.prod.outlook.com (10.174.109.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Tue, 21 Jan 2020 22:41:57 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 22:41:57 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: Fix TLB invalidation request when using
 semaphore
To: amd-gfx@lists.freedesktop.org, Yong Zhao <yong.zhao@amd.com>,
 "Zeng, Oak" <Oak.Zeng@amd.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20200118013735.19361-1-Felix.Kuehling@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <e6c483dc-cafc-bd81-5501-286e7f988600@amd.com>
Date: Tue, 21 Jan 2020 17:41:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200118013735.19361-1-Felix.Kuehling@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::18) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Tue, 21 Jan 2020 22:41:56 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5492c12-2b62-4e9e-3603-08d79ec31eee
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0201:|DM5PR1201MB0201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02015E04026B7424169BCC69920D0@DM5PR1201MB0201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(2616005)(956004)(2906002)(6636002)(44832011)(81156014)(16526019)(26005)(36916002)(186003)(8676002)(36756003)(31686004)(66946007)(52116002)(53546011)(86362001)(31696002)(6486002)(8936002)(478600001)(16576012)(110136005)(66556008)(66476007)(5660300002)(316002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0201;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mf+rRTNIuHBcKRjTdxMq3Xt2L0bbf4W/Vywy69T5OqTJVo2LhE8ybesgqCiYs2cu8QnfWj6ivE6mELfKNqJ1Z4lzvd7YDcqPRArNyJIBMOsNnRtK531vmEaHaGIOqRIfcvtQJulEIt236zT5bkWxH+33LOxTq3wmfUxD4JEbZ5wi69jps9EmlCxm7jaDjZB+CpiW6k6l1nr4o0eQP+sex4GxzW6VYv/CE/Vfu0ZuDn9zC3N2j098MyXkOc09F2KToMvXXghMhlPQVzX4VVX4Y1KWOOMsIwrcJt9PqtqNOUtxyHS2fc29QG/6EPajiWa+cwECMUxejipSdxtOGt4HPLcn6fCddnx5I8R0qJGHSS4QmGaTzN6hO2iV4NpsZA8DpNyl9lNLLqV6OEH66ZhpKVJE1SNoFIhzLDDWetxtIsvhcGqc0fCYpNgpVJX6IZE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5492c12-2b62-4e9e-3603-08d79ec31eee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 22:41:57.3172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rM7qg0t9jEFdNBPfaw7l5GNukpAk9g/n9PYPuQjQmeWiRSXxx19w0BCjtDCGFaYq9wzWvDGrMPhhP8YJat25Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
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

VGhhbmsgZm9yIHRoZSByZXZpZXdzLiBJIHB1c2hlZCBwYXRjaCAxIGFuZCAyIGJlY2F1c2UgdGhl
eSdyZSBvYnZpb3VzIApmaXhlcy4gVGhleSBoYXZlIHBhc3NlZCBsb2NhbCB0ZXN0aW5nIG9uIGEg
VmVnYTEwLiBJJ20gc3RpbGwgd2FpdGluZyBmb3IgCmFuIG9wcG9ydHVuaXR5IHRvIHRlc3QgdGhl
IHJlLXdvcmtlZCB3b3JrYXJvdW5kIGluIHBhdGNoIDMgb24gYSAKcHJvYmxlbWF0aWMgc3lzdGVt
IHdpdGggVmVnYTIwIGFuZCBYR01JLgoKUmVnYXJkcywKIMKgIEZlbGl4CgpPbiAyMDIwLTAxLTE3
IDg6MzcgcC5tLiwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4gVXNlIGEgbW9yZSBtZWFuaW5nZnVs
IHZhcmlhYmxlIG5hbWUgZm9yIHRoZSBpbnZhbGlkYXRpb24gcmVxdWVzdAo+IHRoYXQgaXMgZGlz
dGluY3QgZnJvbSB0aGUgdG1wIHZhcmlhYmxlIHRoYXQgZ2V0cyBvdmVyd3JpdHRlbiB3aGVuCj4g
YWNxdWlyaW5nIHRoZSBpbnZhbGlkYXRpb24gc2VtYXBob3JlLgo+Cj4gRml4ZXM6IDAwZjYwN2Yz
OGQ4MiAoImRybS9hbWRncHU6IGludmFsaWRhdGUgbW1odWIgc2VtYXBob3JlIHdvcmthcm91bmQg
aW4gZ21jOS9nbWMxMCIpCj4gU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djEwXzAuYyB8IDUgKysrLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8w
LmMgIHwgOCArKysrLS0tLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z21jX3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+IGlu
ZGV4IDg2ZjRmZmU0MDhlNy4uZDkxNDU1NWUxMjEyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3YxMF8wLmMKPiBAQCAtMjYyLDcgKzI2Miw4IEBAIHN0YXRpYyB2b2lkIGdtY192
MTBfMF9mbHVzaF92bV9odWIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZt
aWQsCj4gICB7Cj4gICAJYm9vbCB1c2Vfc2VtYXBob3JlID0gZ21jX3YxMF8wX3VzZV9pbnZhbGlk
YXRlX3NlbWFwaG9yZShhZGV2LCB2bWh1Yik7Cj4gICAJc3RydWN0IGFtZGdwdV92bWh1YiAqaHVi
ID0gJmFkZXYtPnZtaHViW3ZtaHViXTsKPiAtCXUzMiB0bXAgPSBnbWNfdjEwXzBfZ2V0X2ludmFs
aWRhdGVfcmVxKHZtaWQsIGZsdXNoX3R5cGUpOwo+ICsJdTMyIGludl9yZXEgPSBnbWNfdjEwXzBf
Z2V0X2ludmFsaWRhdGVfcmVxKHZtaWQsIGZsdXNoX3R5cGUpOwo+ICsJdTMyIHRtcDsKPiAgIAkv
KiBVc2UgcmVnaXN0ZXIgMTcgZm9yIEdBUlQgKi8KPiAgIAljb25zdCB1bnNpZ25lZCBlbmcgPSAx
NzsKPiAgIAl1bnNpZ25lZCBpbnQgaTsKPiBAQCAtMjg5LDcgKzI5MCw3IEBAIHN0YXRpYyB2b2lk
IGdtY192MTBfMF9mbHVzaF92bV9odWIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQz
Ml90IHZtaWQsCj4gICAJCQlEUk1fRVJST1IoIlRpbWVvdXQgd2FpdGluZyBmb3Igc2VtIGFjcXVp
cmUgaW4gVk0gZmx1c2ghXG4iKTsKPiAgIAl9Cj4gICAKPiAtCVdSRUczMl9OT19LSVEoaHViLT52
bV9pbnZfZW5nMF9yZXEgKyBlbmcsIHRtcCk7Cj4gKwlXUkVHMzJfTk9fS0lRKGh1Yi0+dm1faW52
X2VuZzBfcmVxICsgZW5nLCBpbnZfcmVxKTsKPiAgIAo+ICAgCS8qCj4gICAJICogSXNzdWUgYSBk
dW1teSByZWFkIHRvIHdhaXQgZm9yIHRoZSBBQ0sgcmVnaXN0ZXIgdG8gYmUgY2xlYXJlZAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+IGluZGV4IDU0YmRjMTc4NmFiMS4uNmQ5
NWRlMTQxM2M0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
OV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4gQEAg
LTQ3NiwxMyArNDc2LDEzIEBAIHN0YXRpYyB2b2lkIGdtY192OV8wX2ZsdXNoX2dwdV90bGIoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCj4gICB7Cj4gICAJYm9vbCB1
c2Vfc2VtYXBob3JlID0gZ21jX3Y5XzBfdXNlX2ludmFsaWRhdGVfc2VtYXBob3JlKGFkZXYsIHZt
aHViKTsKPiAgIAljb25zdCB1bnNpZ25lZCBlbmcgPSAxNzsKPiAtCXUzMiBqLCB0bXA7Cj4gKwl1
MzIgaiwgaW52X3JlcSwgdG1wOwo+ICAgCXN0cnVjdCBhbWRncHVfdm1odWIgKmh1YjsKPiAgIAo+
ICAgCUJVR19PTih2bWh1YiA+PSBhZGV2LT5udW1fdm1odWJzKTsKPiAgIAo+ICAgCWh1YiA9ICZh
ZGV2LT52bWh1Ylt2bWh1Yl07Cj4gLQl0bXAgPSBnbWNfdjlfMF9nZXRfaW52YWxpZGF0ZV9yZXEo
dm1pZCwgZmx1c2hfdHlwZSk7Cj4gKwlpbnZfcmVxID0gZ21jX3Y5XzBfZ2V0X2ludmFsaWRhdGVf
cmVxKHZtaWQsIGZsdXNoX3R5cGUpOwo+ICAgCj4gICAJLyogVGhpcyBpcyBuZWNlc3NhcnkgZm9y
IGEgSFcgd29ya2Fyb3VuZCB1bmRlciBTUklPViBhcyB3ZWxsCj4gICAJICogYXMgR0ZYT0ZGIHVu
ZGVyIGJhcmUgbWV0YWwKPiBAQCAtNDkzLDcgKzQ5Myw3IEBAIHN0YXRpYyB2b2lkIGdtY192OV8w
X2ZsdXNoX2dwdV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQs
Cj4gICAJCXVpbnQzMl90IHJlcSA9IGh1Yi0+dm1faW52X2VuZzBfcmVxICsgZW5nOwo+ICAgCQl1
aW50MzJfdCBhY2sgPSBodWItPnZtX2ludl9lbmcwX2FjayArIGVuZzsKPiAgIAo+IC0JCWFtZGdw
dV92aXJ0X2tpcV9yZWdfd3JpdGVfcmVnX3dhaXQoYWRldiwgcmVxLCBhY2ssIHRtcCwKPiArCQlh
bWRncHVfdmlydF9raXFfcmVnX3dyaXRlX3JlZ193YWl0KGFkZXYsIHJlcSwgYWNrLCBpbnZfcmVx
LAo+ICAgCQkJCTEgPDwgdm1pZCk7Cj4gICAJCXJldHVybjsKPiAgIAl9Cj4gQEAgLTUyMSw3ICs1
MjEsNyBAQCBzdGF0aWMgdm9pZCBnbWNfdjlfMF9mbHVzaF9ncHVfdGxiKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLAo+ICAgCQkJRFJNX0VSUk9SKCJUaW1lb3V0IHdh
aXRpbmcgZm9yIHNlbSBhY3F1aXJlIGluIFZNIGZsdXNoIVxuIik7Cj4gICAJfQo+ICAgCj4gLQlX
UkVHMzJfTk9fS0lRKGh1Yi0+dm1faW52X2VuZzBfcmVxICsgZW5nLCB0bXApOwo+ICsJV1JFRzMy
X05PX0tJUShodWItPnZtX2ludl9lbmcwX3JlcSArIGVuZywgaW52X3JlcSk7Cj4gICAKPiAgIAkv
Kgo+ICAgCSAqIElzc3VlIGEgZHVtbXkgcmVhZCB0byB3YWl0IGZvciB0aGUgQUNLIHJlZ2lzdGVy
IHRvIGJlIGNsZWFyZWQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
