Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF3AC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162362072F
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HylIhpf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162362072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7992E6E1F5;
	Tue,  2 Jun 2020 19:51:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8186E1F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 19:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2OxTVmCZxc5mokk16NKxqOkmStJFK9sFEjBgepji5mH3Q5aMZmUzXKWD1cZvHrEuTaPGvDtyslgquXTUbKsf4ymmiDpgij7UGZK36SZ8y2xdInSfFuWrFXuxr9Bu0P/hHtr5799kpL8p6yv2NMH3q8m7cGjl8s9umFrRHVVOtH8gO0dZmEoLH2L8gB+qVs3Goq7zT93p/yX88b5GETpkaglt6S2a4Qn3cxwIc0RibWvxXSQKNgqF5zGOk/vSWHCKV7PMHglTI/rMqWCknMhAbSUeRiXVUk/g1WZd3qrVd+0fa5jJ+MhWABjsU1HbReBT+nHQdt98iM2eoLMvzVk2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWbH6iG0AX0RwE1OCaNUGCsXYYsU79KLZnuw9wcRb0I=;
 b=bfrdzWGOUKzVuEVT6Ma0MXLZPb2nFXq31t0IFC+xt+EcbhqDARokxRXhzXdzEo4MnnQnMudFZWrXx+PxnVgwOy2qAplFbVrzqoiHGbUcuKSondi/1F7wZUh6eeHwTLlRqRmw8W/VlWsxAMtSeUm27DAnT5BXzpZk7jFzJv7h8hZ7bXC4uGDAdR2+ynbwv51Ict6Ve7+0zqjtwbW2Fo+sLTG/V8VE/DwDzuYg5Y21ydNbdmOi1sNs1fhkMSZmEv10xwAukvJ1dz4Yf7kaC4Gq6vmizQZIW9Snq9wMONtzANgqBKVoftwtfR27+AMACkKzxR9pMdrteYVjFHckDA9hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWbH6iG0AX0RwE1OCaNUGCsXYYsU79KLZnuw9wcRb0I=;
 b=HylIhpf52QE3BT89uIMjNuUqzDE2FQuWwfKsqSLN3YqA/WnzZ52aSPFP5mm94UuGNAbDwJLn1xwOAK0lVtMdpnWzufxfDGLpZiZIfHPLgIATeUyR6YARFPyyDaqnl8rDA4yPJWCFfnNIxpzhf2l+KavesAvuowBtdSfVyIuo568=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2603.namprd12.prod.outlook.com (2603:10b6:5:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 2 Jun
 2020 19:51:13 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 19:51:13 +0000
Subject: Re: [PATCH] drm/amdgpu: restrict bo mapping within gpu address limits
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200602182735.5940-1-rajneesh.bhardwaj@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0c1e4120-e8fd-585f-f785-0cb081636ac9@amd.com>
Date: Tue, 2 Jun 2020 21:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200602182735.5940-1-rajneesh.bhardwaj@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0036.eurprd07.prod.outlook.com
 (2603:10a6:200:42::46) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0701CA0036.eurprd07.prod.outlook.com (2603:10a6:200:42::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.8 via Frontend
 Transport; Tue, 2 Jun 2020 19:51:12 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c459bec0-0d0d-40b4-b469-08d8072e4e45
X-MS-TrafficTypeDiagnostic: DM6PR12MB2603:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2603494447FB0E562CF76FDF838B0@DM6PR12MB2603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuGZfGy9vxCjk0npLKHELpkXUzCtnJj1b3fXfwaSRc1CyP+1yXBFrmmr9G7P+Ggjo350wJY8Mp+P7wmcFbUb9IdDlQ8XLPT5Xihwzq2mNUaZ3Rn9GfHriOm1klD/G45CoWus3hrMzNPClWuZzBFBiZwWm3iIsxNw4jk8PnSmn1S2bSkPJOVu2lQ92vm3uvTsmbv1dNqzAXs83WTqgiGa25BdrOZJZz3t5ZRkCx8/3yHM12tPvO+Rl1rRCMhn4tbJPEhC2q1Db1p3bCZzingsjt6RUtGORPUOLyW3jx0e9UVt/T4/eFf4E1FJsN/Zt8fETcalWI9fKvlfDpbfArYhsF3b8DQB/K5YWXrO4mrFccSZhP3DrCJaKVEAIgX5RSrH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(478600001)(66556008)(316002)(66946007)(86362001)(66476007)(6486002)(36756003)(31696002)(83380400001)(2616005)(6666004)(186003)(16526019)(8676002)(4326008)(52116002)(31686004)(66574014)(5660300002)(8936002)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CGFgBqXj5JqDjyUd/cYtD7H72PLUkaxFekw1wAd6n9Gcid2euIMDnw8/G3Zb04VkVmzLXARiJ7ZVvNO+FsKjWYBH964ABvKRdxEQGQrVo+gvoYEgayL5IyGRmxV9T3as4THYRTYBsqyNs6rfnvgGV6MCbOGSMrwSQPBz4sJOYfjPzMJrsuWDT5BfYsCX5pNr/nx9ldd67Jz1T3hfnf3D8o5ZJSJbtD27x70kqMEm9SnfaWjYnv1/bwTmzKglYRFqpLX4KgYwRmH0z+/SrGvfb245Dj2An5to5GbIazCnEMPSUlmCInvuKXhYcDrD0orLFWJS0IsKa6z29jthIEnNb6C24QvpkusQBC57w6Vj50Sf8iH8t1LKNmR1Kqw39oiU0MSvcA2NwmQWJ5uUFtS86ID45EZhXX+gG68G0APURNGCsXfnlUPqu7sHneWgBBivGUu4M+W9lSvTs0+VRvQxwd3cLGSbZkYc78TMRzYIhnZBhXefxhLN2ec/rKygDWYM6RnFSaWZFUl54/h8gOV59wO1SGDtSmj8qX/cMLj2TmPPTx1aZdkepJdNVn3un3Pl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c459bec0-0d0d-40b4-b469-08d8072e4e45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 19:51:13.7838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKOiUft1WKHDYkRlbySVj4UMR2WALnTd0gT/audc4qTxlWbOzQHTZlwfevGjpQOO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgUmFqbmVlc2gsCgpJIHRoaW5rIHdlIGhhdmUgcmV2aWV3ZWQgdGhlIHBhdGNoIG11bHRpcGxl
IHRpbWVzIG5vdywgeW91IGNhbiBwdXNoIGl0IAp0byB0aGUgYW1kLXN0YWdpbmctZHJtLW5leHQg
YnJhbmNoLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKQW0gMDIuMDYuMjAgdW0gMjA6Mjcgc2Nocmll
YiBSYWpuZWVzaCBCaGFyZHdhajoKPiBIYXZlIHN0cmljdCBjaGVjayBvbiBibyBtYXBwaW5nIHNp
bmNlIG9uIHNvbWUgc3lzdGVtcywgc3VjaCBhcyBBK0Egb3IKPiBoeWJyaWQsIHRoZSBjcHUgbWln
aHQgc3VwcG9ydCA1IGxldmVsIHBhZ2luZyBvciBjYW4gYWRkcmVzcyBtZW1vcnkgYWJvdmUKPiA0
OCBiaXRzIGJ1dCBncHUgbWlnaHQgYmUgbGltaXRlZCBieSBoYXJkd2FyZSB0byBqdXN0IHVzZSA0
OCBiaXRzLiBJbgo+IGdlbmVyYWwsIHRoaXMgYXBwbGllcyB0byBhbGwgYXNpY3Mgd2hlcmUgdGhp
cyBsaW1pdGF0aW9uIGNhbiBiZSBjaGVja2VkCj4gYWdhaW5zdCB0aGVpciBtYXhfcGZuIHJhbmdl
LiBUaGlzIHJlc3RyaWN0cyB0aGUgcmFuZ2UgdG8gbWFwIGJvIHdpdGhpbgo+IHByYXRpY2FsIGxp
bWl0cyBvZiBjcHUgYW5kIGdwdSBmb3Igc2hhcmVkIHZpcnR1YWwgbWVtb3J5IGFjY2Vzcy4KPgo+
IFJldmlld2VkLWJ5OiBPYWsgWmVuZyA8b2FrLnplbmdAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IFJldmlld2VkLWJ5
OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Cj4gQWNrZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBSYWpu
ZWVzaCBCaGFyZHdhaiA8cmFqbmVlc2guYmhhcmR3YWpAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNiArKysrLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IGluZGV4IDc0MTc3NTRlOTE0MS4uNzFlMDA1Y2YyOTUy
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMjIwOCw3
ICsyMjA4LDggQEAgaW50IGFtZGdwdV92bV9ib19tYXAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCj4gICAJLyogbWFrZSBzdXJlIG9iamVjdCBmaXQgYXQgdGhpcyBvZmZzZXQgKi8KPiAgIAll
YWRkciA9IHNhZGRyICsgc2l6ZSAtIDE7Cj4gICAJaWYgKHNhZGRyID49IGVhZGRyIHx8Cj4gLQkg
ICAgKGJvICYmIG9mZnNldCArIHNpemUgPiBhbWRncHVfYm9fc2l6ZShibykpKQo+ICsJICAgIChi
byAmJiBvZmZzZXQgKyBzaXplID4gYW1kZ3B1X2JvX3NpemUoYm8pKSB8fAo+ICsJICAgIChlYWRk
ciA+PSBhZGV2LT52bV9tYW5hZ2VyLm1heF9wZm4gPDwgQU1ER1BVX0dQVV9QQUdFX1NISUZUKSkK
PiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gICAKPiAgIAlzYWRkciAvPSBBTURHUFVfR1BVX1BBR0Vf
U0laRTsKPiBAQCAtMjI3Myw3ICsyMjc0LDggQEAgaW50IGFtZGdwdV92bV9ib19yZXBsYWNlX21h
cChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkvKiBtYWtlIHN1cmUgb2JqZWN0IGZp
dCBhdCB0aGlzIG9mZnNldCAqLwo+ICAgCWVhZGRyID0gc2FkZHIgKyBzaXplIC0gMTsKPiAgIAlp
ZiAoc2FkZHIgPj0gZWFkZHIgfHwKPiAtCSAgICAoYm8gJiYgb2Zmc2V0ICsgc2l6ZSA+IGFtZGdw
dV9ib19zaXplKGJvKSkpCj4gKwkgICAgKGJvICYmIG9mZnNldCArIHNpemUgPiBhbWRncHVfYm9f
c2l6ZShibykpIHx8Cj4gKwkgICAgKGVhZGRyID49IGFkZXYtPnZtX21hbmFnZXIubWF4X3BmbiA8
PCBBTURHUFVfR1BVX1BBR0VfU0hJRlQpKQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAo+ICAg
CS8qIEFsbG9jYXRlIGFsbCB0aGUgbmVlZGVkIG1lbW9yeSAqLwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
