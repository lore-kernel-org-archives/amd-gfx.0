Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DAFC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F98206DA
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s3cTJQON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F98206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4504B6E094;
	Fri, 20 Dec 2019 21:35:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD1806E094
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 21:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm0oUfvGWEZqdtUCpKHL3ANbi4gDDnJfBcAZyqMhelkVKdu4RU+kWopWGnAciEHc9ldBTDdzbyVk5QcgTSaN4Ifsbj2s614KJJMO6673CcTIek0Y/eNJ1Wmj/vwbqzaWVTCEZLOoQ5a37UpL/CiDSxcvG2HixVr9uaezOUqLgo3vBB/kmLUE58E14UgaSZomMd7Je26uW1mhjwwLJVKOUAkgrRYSGbAPNxO5ecCSDDV65q4bek26BMPoLabHfN6kWUsy6j9yOhDxsZac+KWQRKMpsbF9cmTzPZxkufB7PYIxIjkPlJdhpUHEgcFmyMtrWECefRoC9dHw6ucaszlMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jFuVH5m0fnktqNulLuk2RekzNkzyfEnG//M5MlbXGg=;
 b=WmwEggXFVSMPnbrvD96tEaIHVblkof/1pHO5imPh12ShCznit0jQYNhnkk8Ff3Tcw4mEU+SuIbDzG7maOCtlSkegpLq1L5LAFzTh8VcFCOW22r1yH0bgVzsAsJ8CyMz77K0vf6KG3iv1ia+LpB5/mciOgRZTKdZLgmHuIxnDamUDrjWm1+5WXt24R/FRiVad256piUOlvWyQ4zAE94C0A0dWr06BzSDaWUps+f0+oehvKWSnw3wn0cMuNRr5uauPCBd6stW4YzPCZgx6DE7OmKnIYrV0wOUExGpiEa30v/J+RjENfnI3+1RvjzXQ03yBSvzqje0H0J+gM1TAOE/Icw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jFuVH5m0fnktqNulLuk2RekzNkzyfEnG//M5MlbXGg=;
 b=s3cTJQONY9/ZE2owqa44pq+yyzOqT5mQiSgDCqFKsx9IAU/FzjXMIwVJ1uDujw3qTVHmOOp7vv7MEvP0QihSJGVzg7lXs4EIR5nJK9cnQFk1FbXhmVERbKQhp1NaWgur9S37I3DmG7rZ6mdZYTlRIs8QN5hzrA4lmDiNMv/KS3g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3245.namprd12.prod.outlook.com (20.179.82.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 21:35:39 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08%6]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 21:35:39 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu: GPU TLB flush API moved to amdgpu_amdkfd
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191220062442.33635-1-alex.sierra@amd.com>
 <20191220062442.33635-3-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <41542c9c-a668-0a4b-1f3f-9b38c8e48d12@amd.com>
Date: Fri, 20 Dec 2019 16:35:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191220062442.33635-3-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 20 Dec 2019 21:35:38 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5af230ce-8b8f-45f8-5bfa-08d785948e9d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3245:|MN2PR12MB3245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32457B6FC4A5C6AA1D86ACFA922D0@MN2PR12MB3245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(44832011)(2616005)(478600001)(66556008)(31686004)(66476007)(66946007)(6486002)(16576012)(2906002)(26005)(52116002)(186003)(16526019)(316002)(53546011)(8936002)(36756003)(5660300002)(8676002)(4001150100001)(81166006)(81156014)(31696002)(956004)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3245;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsaKjM1dLS1ODH+rCV1WQ4oXYRCN6V/OhBPZaOaPp55du8l1l3xOgMHxt+lcSXfzoo8DOkjdL2SXAhARcJHg7ST7ivDvFpwMP9JsCv4BFW5Sl/7Q6mcWybDuOj9B/YABAXGgpJnKbK+LxemMx2wFzhl3TgCzE4edy4pbXaRFoLDSEXDeD9RhA5wW/DCAeQlG2lsJKH+SZEJ8WNAUcKTLGwe0Ej3B1A2AFm1taznMX2TcFMHtKv2ktXUeDcUucON1f/Smn7hj8jjm68xvcwHCplsqly8FMtyhW6NhaNAqDjwIr0d0Fw/bc6zevoPFKCVHGHPrNSoZ+cDAZS7N8jEGXeCNQ3qbM5p5SRvolpYOrAcypRSa5Alu0a10xoVexLOFDRXN4EU8NIidiNE/FmuJaNCvG7XyVtcRHEJzPs5uYdk5d4yPxZDJNYtReb4jvFk+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af230ce-8b8f-45f8-5bfa-08d785948e9d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 21:35:39.1915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4gnJKylWu4ekakbAHQOHAUqtocP6gRN+mRCCHtJAjtlNtPAuQCsfGsHkVibVbU6UVyp2Hf4lt5XaeZaAFv3Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3245
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

T24gMjAxOS0xMi0yMCAxOjI0LCBBbGV4IFNpZXJyYSB3cm90ZToKPiBbV2h5XQo+IFRMQiBmbHVz
aCBtZXRob2QgaGFzIGJlZW4gZGVwcmVjYXRlZCB1c2luZyBrZmQya2dkIGludGVyZmFjZS4KPiBU
aGlzIGltcGxlbWVudGF0aW9uIGlzIG5vdyBvbiB0aGUgYW1kZ3B1X2FtZGtmZCBBUEkuCj4KPiBb
SG93XQo+IFRMQiBmbHVzaCBmdW5jdGlvbnMgbm93IGltcGxlbWVudGVkIGluIGFtZGdwdV9hbWRr
ZmQuCj4KPiBDaGFuZ2UtSWQ6IEljNTFjY2NkZmU2ZTcxMjg4ZDc4ZGE3NzJiNmUxYjZjZWQ3MmY4
ZWY3Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+CgpM
b29rcyBnb29kIHRvIG1lLiBTZWUgbXkgY29tbWVudCBhYm91dCB0aGUgVE9ETyBpbmxpbmUuCgoK
PiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyB8IDMy
ICsrKysrKysrKysrKysrKysrKysrKysKPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmQuaCB8ICAyICsrCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJvY2Vzcy5jICAgfCAgOCArKysrLS0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkLmMKPiBpbmRleCBkM2RhOWRkZTRlZTEuLmI3ZjZlNzBjNTc2MiAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPiBAQCAtNjM0LDYgKzYz
NCwzOCBAQCBib29sIGFtZGdwdV9hbWRrZmRfaXNfa2ZkX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHUzMiB2bWlkKQo+ICAgCXJldHVybiBmYWxzZTsKPiAgIH0KPiAgIAo+ICtpbnQg
YW1kZ3B1X2FtZGtmZF9mbHVzaF9ncHVfdGxiX3ZtaWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWlu
dDE2X3Qgdm1pZCkKPiArewo+ICsJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKilrZ2Q7Cj4gKwkvKiBUT0RPOiBjb25kaXRpb24gbWlzc2luZyBmb3Ig
RkFNSUxZIGFib3ZlIE5WICovCgpJJ20gbm90IHN1cmUgd2hhdCdzIG1pc3NpbmcgaGVyZS4gTlYg
YW5kIGFib3ZlIGRvbid0IG5lZWQgYW55IHNwZWNpYWwgCnRyZWF0bWVudC4gU2luY2UgU0RNQSBp
cyBjb25uZWN0ZWQgdG8gR0ZYSFVCIG9uIE5WLCBvbmx5IHRoZSBHRlhIVUIgCm5lZWRzIHRvIGJl
IGZsdXNoZWQuCgpSZWdhcmRzLAogwqAgRmVsaXgKCgo+ICsJaWYgKGFkZXYtPmZhbWlseSA9PSBB
TURHUFVfRkFNSUxZX0FJKSB7Cj4gKwkJaW50IGk7Cj4gKwo+ICsJCWZvciAoaSA9IDA7IGkgPCBh
ZGV2LT5udW1fdm1odWJzOyBpKyspCj4gKwkJCWFtZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYihhZGV2
LCB2bWlkLCBpLCAwKTsKPiArCX0gZWxzZSB7Cj4gKwkJYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxi
KGFkZXYsIHZtaWQsIEFNREdQVV9HRlhIVUJfMCwgMCk7Cj4gKwl9Cj4gKwo+ICsJcmV0dXJuIDA7
Cj4gK30KPiArCj4gK2ludCBhbWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90bGJfcGFzaWQoc3RydWN0
IGtnZF9kZXYgKmtnZCwgdWludDE2X3QgcGFzaWQpCj4gK3sKPiArCXN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopa2dkOwo+ICsJdWludDMyX3QgZmx1
c2hfdHlwZSA9IDA7Cj4gKwlib29sIGFsbF9odWIgPSBmYWxzZTsKPiArCj4gKwlpZiAoYWRldi0+
Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzICYmCj4gKwkJYWRldi0+YXNpY190eXBlID09IENI
SVBfVkVHQTIwKQo+ICsJCWZsdXNoX3R5cGUgPSAyOwo+ICsKPiArCWlmIChhZGV2LT5mYW1pbHkg
PT0gQU1ER1BVX0ZBTUlMWV9BSSkKPiArCQlhbGxfaHViID0gdHJ1ZTsKPiArCj4gKwlyZXR1cm4g
YW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiX3Bhc2lkKGFkZXYsIHBhc2lkLCBmbHVzaF90eXBlLCBh
bGxfaHViKTsKPiArfQo+ICsKPiAgIGJvb2wgYW1kZ3B1X2FtZGtmZF9oYXZlX2F0b21pY3Nfc3Vw
cG9ydChzdHJ1Y3Qga2dkX2RldiAqa2dkKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopa2dkOwo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgKPiBpbmRleCAwNjlkNWQyMzA4MTAuLjQ3YjBmMjk1
N2QxZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgK
PiBAQCAtMTM2LDYgKzEzNiw4IEBAIGludCBhbWRncHVfYW1ka2ZkX3N1Ym1pdF9pYihzdHJ1Y3Qg
a2dkX2RldiAqa2dkLCBlbnVtIGtnZF9lbmdpbmVfdHlwZSBlbmdpbmUsCj4gICAJCQkJdWludDMy
X3QgKmliX2NtZCwgdWludDMyX3QgaWJfbGVuKTsKPiAgIHZvaWQgYW1kZ3B1X2FtZGtmZF9zZXRf
Y29tcHV0ZV9pZGxlKHN0cnVjdCBrZ2RfZGV2ICprZ2QsIGJvb2wgaWRsZSk7Cj4gICBib29sIGFt
ZGdwdV9hbWRrZmRfaGF2ZV9hdG9taWNzX3N1cHBvcnQoc3RydWN0IGtnZF9kZXYgKmtnZCk7Cj4g
K2ludCBhbWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90bGJfdm1pZChzdHJ1Y3Qga2dkX2RldiAqa2dk
LCB1aW50MTZfdCB2bWlkKTsKPiAraW50IGFtZGdwdV9hbWRrZmRfZmx1c2hfZ3B1X3RsYl9wYXNp
ZChzdHJ1Y3Qga2dkX2RldiAqa2dkLCB1aW50MTZfdCBwYXNpZCk7Cj4gICAKPiAgIGJvb2wgYW1k
Z3B1X2FtZGtmZF9pc19rZmRfdm1pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIHZt
aWQpOwo+ICAgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9w
cm9jZXNzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4gaW5k
ZXggNTM2YTE1M2FjOWE0Li4yNWI5MGY3MGFlY2QgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9wcm9jZXNzLmMKPiBAQCAtMzIsNiArMzIsNyBAQAo+ICAgI2luY2x1ZGUgPGxp
bnV4L21tYW4uaD4KPiAgICNpbmNsdWRlIDxsaW51eC9maWxlLmg+Cj4gICAjaW5jbHVkZSAiYW1k
Z3B1X2FtZGtmZC5oIgo+ICsjaW5jbHVkZSAiYW1kZ3B1LmgiCj4gICAKPiAgIHN0cnVjdCBtbV9z
dHJ1Y3Q7Cj4gICAKPiBAQCAtMTE1MiwxNiArMTE1MywxNyBAQCBpbnQga2ZkX3Jlc2VydmVkX21l
bV9tbWFwKHN0cnVjdCBrZmRfZGV2ICpkZXYsIHN0cnVjdCBrZmRfcHJvY2VzcyAqcHJvY2VzcywK
PiAgIHZvaWQga2ZkX2ZsdXNoX3RsYihzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQpCj4g
ICB7Cj4gICAJc3RydWN0IGtmZF9kZXYgKmRldiA9IHBkZC0+ZGV2Owo+IC0JY29uc3Qgc3RydWN0
IGtmZDJrZ2RfY2FsbHMgKmYyZyA9IGRldi0+a2ZkMmtnZDsKPiAgIAo+ICAgCWlmIChkZXYtPmRx
bS0+c2NoZWRfcG9saWN5ID09IEtGRF9TQ0hFRF9QT0xJQ1lfTk9fSFdTKSB7Cj4gICAJCS8qIE5v
dGhpbmcgdG8gZmx1c2ggdW50aWwgYSBWTUlEIGlzIGFzc2lnbmVkLCB3aGljaAo+ICAgCQkgKiBv
bmx5IGhhcHBlbnMgd2hlbiB0aGUgZmlyc3QgcXVldWUgaXMgY3JlYXRlZC4KPiAgIAkJICovCj4g
ICAJCWlmIChwZGQtPnFwZC52bWlkKQo+IC0JCQlmMmctPmludmFsaWRhdGVfdGxic192bWlkKGRl
di0+a2dkLCBwZGQtPnFwZC52bWlkKTsKPiArCQkJYW1kZ3B1X2FtZGtmZF9mbHVzaF9ncHVfdGxi
X3ZtaWQoZGV2LT5rZ2QsCj4gKwkJCQkJCQlwZGQtPnFwZC52bWlkKTsKPiAgIAl9IGVsc2Ugewo+
IC0JCWYyZy0+aW52YWxpZGF0ZV90bGJzKGRldi0+a2dkLCBwZGQtPnByb2Nlc3MtPnBhc2lkKTsK
PiArCQlhbWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90bGJfcGFzaWQoZGV2LT5rZ2QsCj4gKwkJCQkJ
CXBkZC0+cHJvY2Vzcy0+cGFzaWQpOwo+ICAgCX0KPiAgIH0KPiAgIApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
