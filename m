Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC72C34031
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 23:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6D224125
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 23:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="01Cb3Crv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6D224125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A8AC6EAE1;
	Tue, 18 Feb 2020 23:10:06 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700067.outbound.protection.outlook.com [40.107.70.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C596EAE1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 23:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlPA/BH7kXdvS8fvGsRF7wFUbqjOr8MQOlNgSBwIO0qPo+GkF9m33HrcV+1cs3TKdNhRygl622naqA3LV3srt4+JtTdklBqEHnDJrY32nTkuaMatb8yWsfZ2vFZ+LyP1lFJGQjIXg0L8QT2u3g4yLDr+/1VXCtKy6hg97p2KtbWr5NXlTDXLvB77ElHeHRfz7uVXbYCrL6Yu0ifW4lPjHYGV3qR1AgIQHAPKsJxE4VHTDqceMmEHQsIzy8jTOUslZe4bEYXkJ0nM1OSXCt64f4hqiqCRsFY1MwqTI1YUEENjDAkoO5pXY+oFef+rmlIUWNyGgLtDS/qOPsbymNou2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrAWVUEsB5m+A8vRLaUBf/TRdVBTBdUnvU2jAmhSmFw=;
 b=EQ8JCfcTz2L33t9dgJuYE3rlGpr/meLHUoBXYNkKeBH2GYk+R4UFbvstRG4G0ofDvFKZPTwMP27n692tVD8Cy2tPQpkl8etT7NIo7qEqTNDF7tfOEX13N5FskcOQmeTUVsmiZ8M7wZP694dGUOZAAjTVUo1fGxibubLcXIvNttWP5Q8VmK65pb7M4ynCKq13b9HHf3gFjvcIInsUlh6UAh5t+/iW3UWymeQZgr//RX20gLdXad9jECJaS6IKIoaV1zzIjDc8rLXD7ys3UcWegwA2Ban7Yi2kDhinqliBnecp9QW4QdocL+HjNVFxx6QpPgY6xjQvUPzLeKNqKZLJZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrAWVUEsB5m+A8vRLaUBf/TRdVBTBdUnvU2jAmhSmFw=;
 b=01Cb3CrvCTCU4PVlU3aGNLvpzkUmErjG1uUqQvrRWfTDfUEtrr+/bG1G1LErxye4E1hNFHoqNbEt8/DtzH8BUjKboV3Gu0U40pf5U5U5WkAs/rY7NJrCLro/p2ky3hzCZ7sDfJe6TdELJQEI7Q5IkRp/wX2YcTi97bR3HuTaZg4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0092.namprd12.prod.outlook.com (10.174.106.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 23:10:03 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 23:10:02 +0000
Subject: Re: [RFC PATCH v5] drm/amdgpu: Remove kfd eviction fence before
 release bo
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200218033650.7665-1-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <76285bd7-70df-09be-2e05-a4b75bb3e879@amd.com>
Date: Tue, 18 Feb 2020 18:10:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200218033650.7665-1-xinhui.pan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::22) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend
 Transport; Tue, 18 Feb 2020 23:10:02 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 422bc943-d3ca-4adb-b0ea-08d7b4c7af28
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0092:|DM5PR1201MB0092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00926DE57D5A2B07CFD0975592110@DM5PR1201MB0092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(199004)(189003)(31696002)(54906003)(26005)(66574012)(36756003)(6486002)(2906002)(16576012)(66476007)(5660300002)(53546011)(86362001)(31686004)(478600001)(66946007)(4326008)(52116002)(186003)(16526019)(81156014)(81166006)(36916002)(8936002)(8676002)(44832011)(316002)(66556008)(2616005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0092;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g4LBvlMXDUY3SgxiYjv+Hgo9sUxMvzBscZTwvVMwHZRoaZ8Qw6scg9OAF18J/dao+lu12A2r6rjYPuYZ824b6lXhD9O7gGiKq2GPo0VLQ8DKJXMqBBA4J15Z/GGAPlfgBjomas3lOH1tn6gQa3ErAvQN5ttH5Ai73b5/RAJwmbrnW4bx95V4G3lQcNEdfImVDn7vJf39Wv7Bk23RSMRaW6qOcHDsAeAbzgyH5fwpePIevVQUef54Ccp7OqzoNbm190UE8jHMcMIlcASeqMn5qbh85VVgyi9IusGtMKqfRjWHVgtB21xlxD88cLIoZtXVzLWYD1ckJ/A2dhKguRAjfRRi8/CkPqti24TsyMta2S3+OYoT5+sQgHNrQt+q8m4EcHlqxBG8ld1gymu78XxlP6Z10xnZ2ccw/emFkdthSIJrxsmp8AUkZID4TgT80VOi
X-MS-Exchange-AntiSpam-MessageData: 08JpJYtuACZqp6VJT5VUy4PP9eYkkgbg+b4hI/PrVg02Wq/D+cxMRnejU1u9uRGzJ/gN6sl/b0Pla1XIDnaxzcz2sM6/ageZALca6GOKRjtR7OnW+F7DR63ZGCVSqeV0HLT/NNRK5UBKOv7NNQ6TPg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422bc943-d3ca-4adb-b0ea-08d7b4c7af28
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 23:10:02.8624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EI8hUIshCCejqFUKxMXU/5b7oFbmNFTuseCe7FcxggVT+8Ngvj1SFKFhtpeody4aq1u/1splirF4gwMw9SgjUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0092
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

SGkgWGluaHVpLAoKVHdvIHN1Z2dlc3Rpb25zIGlubGluZS4gTG9va3MgZ29vZCB0byBtZSBvdGhl
cndpc2UuCgpPbiAyMDIwLTAyLTE3IDEwOjM2IHAubS4sIHhpbmh1aSBwYW4gd3JvdGU6Cj4gTm8g
bmVlZCB0byB0cmlnZ2VyIGV2aWN0aW9uIGFzIHRoZSBtZW1vcnkgbWFwcGluZyB3aWxsIG5vdCBi
ZSB1c2VkCj4gYW55bW9yZS4KPgo+IEFsbCBwdC9wZCBib3Mgc2hhcmUgc2FtZSByZXN2LCBoZW5j
ZSB0aGUgc2FtZSBzaGFyZWQgZXZpY3Rpb24gZmVuY2UuCj4gRXZlcnl0aW1lIHBhZ2UgdGFibGUg
aXMgZnJlZWQsIHRoZSBmZW5jZSB3aWxsIGJlIHNpZ25sZWQgYW5kIHRoYXQgY3Vhc2VzCj4ga2Zk
IHVuZXhjZXB0ZWQgZXZpY3Rpb25zLgo+Cj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGlu
aHVpLnBhbkBhbWQuY29tPgo+IENDOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cj4gQ0M6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29tPgo+
IENDOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gLS0tCj4gY2hh
bmdlIGZyb20gdjQ6Cj4gYmFzZWQgb24gbmV3IHR0bSBjb2RlLgo+Cj4gY2hhbmdlIGZyb20gdjM6
Cj4gZml4IGEgY29kaW5nIGVycm9yCj4KPiBjaGFuZ2UgZnJvbSB2MjoKPiBiYXNlZCBvbiBDaHJp
cycgZHJtL3R0bTogcmV3b3JrIEJPIGRlbGF5ZWQgZGVsZXRlIHBhdGNoc2V0Lgo+Cj4gLS0tCj4g
LS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmggICAgfCAg
MSArCj4gICAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyAgfCAz
NyArKysrKysrKysrKysrKysrKysrCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfb2JqZWN0LmMgICAgfCAgNCArKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25z
KCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4gaW5k
ZXggOWU4ZGI3MDJkODc4Li4wZWU4YWFlNmM1MTkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4gQEAgLTk2LDYgKzk2LDcgQEAgc3RydWN0IGFtZGdw
dV9hbWRrZmRfZmVuY2UgKmFtZGdwdV9hbWRrZmRfZmVuY2VfY3JlYXRlKHU2NCBjb250ZXh0LAo+
ICAgCQkJCQkJICAgICAgIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKTsKPiAgIGJvb2wgYW1ka2ZkX2Zl
bmNlX2NoZWNrX21tKHN0cnVjdCBkbWFfZmVuY2UgKmYsIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKTsK
PiAgIHN0cnVjdCBhbWRncHVfYW1ka2ZkX2ZlbmNlICp0b19hbWRncHVfYW1ka2ZkX2ZlbmNlKHN0
cnVjdCBkbWFfZmVuY2UgKmYpOwo+ICtpbnQgYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZmVuY2Vfb25f
cHRfcGRfYm9zKHN0cnVjdCBhbWRncHVfYm8gKmJvKTsKPiAgIAo+ICAgc3RydWN0IGFtZGtmZF9w
cm9jZXNzX2luZm8gewo+ICAgCS8qIExpc3QgaGVhZCBvZiBhbGwgVk1zIHRoYXQgYmVsb25nIHRv
IGEgS0ZEIHByb2Nlc3MgKi8KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZF9ncHV2bS5jCj4gaW5kZXggZWY3MjFjYjY1ODY4Li42YWEyMGFhODJiZDMgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2
bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2
bS5jCj4gQEAgLTI3Niw2ICsyNzYsNDEgQEAgc3RhdGljIGludCBhbWRncHVfYW1ka2ZkX3JlbW92
ZV9ldmljdGlvbl9mZW5jZShzdHJ1Y3QgYW1kZ3B1X2JvICpibywKPiAgIAlyZXR1cm4gMDsKPiAg
IH0KPiAgIAo+ICtpbnQgYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZmVuY2Vfb25fcHRfcGRfYm9zKHN0
cnVjdCBhbWRncHVfYm8gKmJvKQo+ICt7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2JvICpyb290ID0gYm87
Cj4gKwlzdHJ1Y3QgYW1kZ3B1X3ZtX2JvX2Jhc2UgKnZtX2JvOwo+ICsJc3RydWN0IGFtZGdwdV92
bSAqdm07Cj4gKwlzdHJ1Y3QgYW1ka2ZkX3Byb2Nlc3NfaW5mbyAqaW5mbzsKPiArCXN0cnVjdCBh
bWRncHVfYW1ka2ZkX2ZlbmNlICplZjsKPiArCWludCByZXQ7Cj4gKwo+ICsJd2hpbGUgKHJvb3Qt
PnBhcmVudCkKPiArCQlyb290ID0gcm9vdC0+cGFyZW50OwoKVGhpcyBzaG91bGQgbm90IGJlIG5l
Y2Vzc2FyeS4gRXZlcnkgcGFnZSB0YWJsZSBCTyBoYXMgYSBwb2ludGVyIHRvIGEgCnZtX2JvIHRo
YXQgaGFzIGEgcG9pbnRlciB0byB0aGUgdm0uIFNvIHlvdSBkb24ndCBuZWVkIHRvIGZpbmQgdGhl
IHJvb3QuCgpUaGlzIHNob3VsZCBkbyB0aGUgdHJpY2s6CgoJaWYgKCFiby0+dm1fYm8gfHwgIWJv
LT52bV9iby0+dm0pCgkJcmV0dXJuIDA7Cgl2bSA9IGJvLT52bV9iby0+dm07CgoKPiArCj4gKwl2
bV9ibyA9IHJvb3QtPnZtX2JvOwo+ICsJaWYgKCF2bV9ibykKPiArCQlyZXR1cm4gMDsKPiArCj4g
Kwl2bSA9IHZtX2JvLT52bTsKPiArCWlmICghdm0pCj4gKwkJcmV0dXJuIDA7Cj4gKwo+ICsJaW5m
byA9IHZtLT5wcm9jZXNzX2luZm87Cj4gKwlpZiAoIWluZm8gfHwgIWluZm8tPmV2aWN0aW9uX2Zl
bmNlKQo+ICsJCXJldHVybiAwOwo+ICsKPiArCWVmID0gY29udGFpbmVyX29mKGRtYV9mZW5jZV9n
ZXQoJmluZm8tPmV2aWN0aW9uX2ZlbmNlLT5iYXNlKSwKPiArCQkJc3RydWN0IGFtZGdwdV9hbWRr
ZmRfZmVuY2UsIGJhc2UpOwo+ICsKPiArCWRtYV9yZXN2X2xvY2soYm8tPnRiby5iYXNlLnJlc3Ys
IE5VTEwpOwo+ICsJcmV0ID0gYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZXZpY3Rpb25fZmVuY2UoYm8s
IGVmKTsKPiArCWRtYV9yZXN2X3VubG9jayhiby0+dGJvLmJhc2UucmVzdik7Cj4gKwo+ICsJZG1h
X2ZlbmNlX3B1dCgmZWYtPmJhc2UpOwo+ICsJcmV0dXJuIHJldDsKPiArfQo+ICsKPiAgIHN0YXRp
YyBpbnQgYW1kZ3B1X2FtZGtmZF9ib192YWxpZGF0ZShzdHJ1Y3QgYW1kZ3B1X2JvICpibywgdWlu
dDMyX3QgZG9tYWluLAo+ICAgCQkJCSAgICAgYm9vbCB3YWl0KQo+ICAgewo+IEBAIC0xMDQ1LDYg
KzEwODAsOCBAQCB2b2lkIGFtZGdwdV9hbWRrZmRfZ3B1dm1fZGVzdHJveV9jYihzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKPiAgIAlsaXN0X2RlbCgmdm0tPnZtX2xpc3Rfbm9kZSk7Cj4gICAJ
bXV0ZXhfdW5sb2NrKCZwcm9jZXNzX2luZm8tPmxvY2spOwo+ICAgCj4gKwl2bS0+cHJvY2Vzc19p
bmZvID0gTlVMTDsKPiArCj4gICAJLyogUmVsZWFzZSBwZXItcHJvY2VzcyByZXNvdXJjZXMgd2hl
biBsYXN0IGNvbXB1dGUgVk0gaXMgZGVzdHJveWVkICovCj4gICAJaWYgKCFwcm9jZXNzX2luZm8t
Pm5fdm1zKSB7Cj4gICAJCVdBUk5fT04oIWxpc3RfZW1wdHkoJnByb2Nlc3NfaW5mby0+a2ZkX2Jv
X2xpc3QpKTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4g
aW5kZXggNmY2MGE1ODFlM2JhLi4xNjU4NjY1MTAyMGYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gQEAgLTEzMDcsNiArMTMwNywxMCBAQCB2b2lk
IGFtZGdwdV9ib19yZWxlYXNlX25vdGlmeShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvKQo+
ICAgCWlmIChhYm8tPmtmZF9ibykKPiAgIAkJYW1kZ3B1X2FtZGtmZF91bnJlc2VydmVfbWVtb3J5
X2xpbWl0KGFibyk7Cj4gICAKPiArCS8qIFdlIG9ubHkgcmVtb3ZlIHRoZSBmZW5jZSBpZiB0aGUg
cmVzdiBoYXMgaW5kaXZpZHVhbGl6ZWQuICovCj4gKwlpZiAoYm8tPmJhc2UucmVzdiA9PSAmYm8t
PmJhc2UuX3Jlc3YpCgpTaG91bGQgdGhpcyBiZSBhIFdBUk5fT04/IFdlIGV4cGVjdCB0aGlzIGNv
bmRpdGlvbiB0byBiZSBhbHdheXMgdHJ1ZS4gSWYgCml0J3Mgbm90LCB0aGVyZSBzaG91bGQgYmUg
YSBub2lzeSB3YXJuaW5nIHRoYXQgc29tZXRoaW5nIGlzIHdyb25nLgoKUmVnYXJkcywKIMKgIEZl
bGl4CgoKPiArCQlhbWRncHVfYW1ka2ZkX3JlbW92ZV9mZW5jZV9vbl9wdF9wZF9ib3MoYWJvKTsK
PiArCj4gICAJaWYgKGJvLT5tZW0ubWVtX3R5cGUgIT0gVFRNX1BMX1ZSQU0gfHwgIWJvLT5tZW0u
bW1fbm9kZSB8fAo+ICAgCSAgICAhKGFiby0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9WUkFN
X1dJUEVfT05fUkVMRUFTRSkpCj4gICAJCXJldHVybjsKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
